use chrono::{Local, NaiveDateTime};
use clap::Parser;
use lazy_static::lazy_static;
use rayon::prelude::*;
use std::{
    collections::HashMap,
    fs::{self, File},
    io::Write,
    path::PathBuf,
    process::{Command, Stdio, exit},
    sync::RwLock,
};
use walkdir::WalkDir;

#[derive(Parser, Debug)]
#[command(author, version, about = "\neg: ./ASMperf -f final -b aarch64 -s /usr/aarch64-redhat-linux/sys-root/fc42/usr/", long_about = None)]
struct Args {
    #[arg(short, long)]
    file_dir: String,

    #[arg(short, long, default_value = "aarch64")]
    backend: String,

    #[arg(short, long, default_value = "default")]
    sysroot: String,
}

struct Sysy {
    pub name: String,
    pub source: Option<PathBuf>,
    pub std_in: Option<PathBuf>,
    pub std_out: Option<PathBuf>,
}

lazy_static! {
    static ref RESULT_DIR: RwLock<PathBuf> = RwLock::new(PathBuf::new());
    static ref SYLIB_PATH: RwLock<PathBuf> = RwLock::new(PathBuf::from("../sylib/sylib.c"));
    static ref QEMU: RwLock<String> = RwLock::new(String::new());
    static ref ISA: RwLock<String> = RwLock::new(String::new());
    static ref LINKER: RwLock<String> = RwLock::new(String::new());
    static ref QEMU_SYS_ROOT: RwLock<Option<String>> = RwLock::new(None);
    static ref GNALC: RwLock<PathBuf> = RwLock::new(PathBuf::new());
    static ref CUR_TIME: RwLock<String> = {
        let naive_time: NaiveDateTime = Local::now().naive_local();
        RwLock::new(naive_time.format("%a-%b-%e-%T-%Y").to_string())
    };
}

fn perf(pack: &Sysy) {
    let output_dir_path = RESULT_DIR.read().unwrap().clone().join(&pack.name);

    let asm = output_dir_path.join(pack.name.to_owned() + ".s");
    let elf = output_dir_path.join(pack.name.to_owned() + ".elf");
    let source_file = pack.source.clone().unwrap();
    let std_in = pack.std_in.clone().unwrap();
    // let std_out = pack.std_out.clone().unwrap();

    if fs::create_dir_all(&output_dir_path).is_err() {
        eprintln!("can't create result dir: {output_dir_path:?}");
        exit(11);
    }

    // compile
    println!("gnalc compile on {}", source_file.to_str().unwrap());

    let compile = Command::new(GNALC.read().unwrap().to_owned())
        .arg("-S")
        .arg(&source_file)
        .arg(format!("-march={}", ISA.read().unwrap()))
        .arg("-O1")
        .arg("-with-runtime")
        .arg("-o")
        .arg(&asm)
        .output();

    match compile {
        Err(e) => {
            eprintln!("gnalc err when compile {source_file:?}, err: {e}");
            exit(5);
        }
        Ok(out) => {
            if out.status.code().unwrap() != 0 {
                eprintln!("gnalc compile error: {out:?}");
                exit(5);
            }
        }
    }

    // link
    println!("linker working on {}", source_file.to_str().unwrap());

    match Command::new(LINKER.read().unwrap().clone())
        .arg(&asm)
        .arg(SYLIB_PATH.read().unwrap().as_path())
        .arg("-o")
        .arg(&elf)
        .output()
    {
        Err(e) => {
            eprintln!("linking error: {e}");
            exit(10);
        }
        Ok(out) => {
            if out.status.code().unwrap() != 0 {
                eprintln!("linking error");
                exit(10);
            }
        }
    }

    // run & perf
    println!("qemu & perf working on {}\n", source_file.to_str().unwrap());

    let mut qemu_perf = Command::new("perf");

    qemu_perf
        .arg("stat")
        .args([
            "-e",
            "L1-dcache-loads",
            "-e",
            "L1-dcache-load-misses",
            "-e",
            "L1-icache-loads",
            "-e",
            "L1-icache-misses",
            "-e",
            "branch-loads",
            "-e",
            "branch-load-misses",
            "-e",
            "branch-instructions",
            "-e",
            "branch-misses",
        ])
        .arg(QEMU.read().unwrap().clone());

    if ISA.read().unwrap().to_string() == "armv8" {
        qemu_perf.arg("-cpu").arg("cortex-a53");
    }

    if let Some(sys) = QEMU_SYS_ROOT.read().unwrap().clone() {
        qemu_perf.arg("-L").arg(sys);
    }

    // println!("qemu & perf command: {:?}", qemu_perf);

    let output = qemu_perf
        .arg(elf)
        .stdin(Stdio::from(File::open(std_in).unwrap()))
        .output();

    let perf_data = match output {
        Err(e) => {
            eprintln!(
                "perf-qemu runtime error on {}: {}",
                source_file.to_str().unwrap(),
                e
            );
            exit(6);
        }
        Ok(d) => String::from_utf8_lossy(&d.stderr).into_owned(),
    };

    let perf_path = output_dir_path.join(pack.name.clone() + ".perf");

    let mut perf_file_handle = match File::create(&perf_path) {
        Ok(fd) => fd,
        Err(e) => {
            eprintln!("cannot create a perf result file {perf_path:?}: {e}");
            exit(7);
        }
    };

    match &perf_data.find(" Performance counter stats") {
        Some(idx) => match perf_file_handle.write(perf_data.split_at(*idx).1.as_bytes()) {
            Ok(_) => (),
            Err(e) => {
                eprintln!("fail to write perf data into file: {e}");
                exit(9);
            }
        },
        None => {
            eprintln!("can't find perf data, stdout: {perf_data}");
            exit(8);
        }
    }
}

fn main() {
    let args = Args::parse();

    if args.file_dir.is_empty() {
        eprintln!("source directory is required");
        exit(1);
    }

    let mut source_path = PathBuf::from(&args.file_dir);

    if source_path.starts_with("./") {
        source_path = source_path.strip_prefix("./").unwrap().to_path_buf();
    } else if source_path.starts_with("../") {
        source_path = source_path.strip_prefix("../").unwrap().to_path_buf();
    }

    if !source_path.starts_with("contest/") {
        source_path = PathBuf::from("../contest").join(&source_path);
    }

    let mut gnalc_path = source_path.clone();
    gnalc_path.push("../../gnalc");

    match std::fs::File::open(gnalc_path.as_path()) {
        Ok(_) => (),
        Err(e) => {
            eprintln!("{gnalc_path:?} doesn't exist: {e}");
            exit(3);
        }
    }

    *GNALC.write().unwrap() = gnalc_path;

    RESULT_DIR
        .write()
        .unwrap()
        .push(format!("../ASMperf_result/{}", CUR_TIME.read().unwrap()));

    if let Err(e) = std::fs::create_dir_all(&*RESULT_DIR.read().unwrap()) {
        eprintln!("Failed to create result directory: {e}");
        exit(2);
    }

    if args.backend == "aarch64" {
        QEMU.write().unwrap().push_str("qemu-aarch64");
        ISA.write().unwrap().push_str("armv8");
        LINKER.write().unwrap().push_str("aarch64-linux-gnu-gcc");
    } else if args.backend == "riscv64" {
        QEMU.write().unwrap().push_str("qemu-riscv64");
        ISA.write().unwrap().push_str("riscv64");
        LINKER.write().unwrap().push_str("riscv64-linux-gnu-gcc");
    } else {
        eprintln!("unknown target backend");
        exit(4);
    }

    if args.sysroot != "default" {
        *QEMU_SYS_ROOT.write().unwrap() = Some(args.sysroot);
    }

    println!("Processing directory: {source_path:?}");
    println!("Compiler path: {:?}", GNALC.read().unwrap());
    println!("Results will be saved to: {:?}", RESULT_DIR.read().unwrap());
    println!(
        "backend: {}",
        QEMU.read().unwrap().strip_prefix("qemu-").unwrap()
    );

    match QEMU_SYS_ROOT.read().unwrap().clone() {
        Some(path) => println!("qemu sysroot: {path}"),

        None => println!("qemu sysroot: not specified"),
    }

    println!("==========================\n");

    // perfing
    let source_file: Vec<_> = WalkDir::new(source_path)
        .into_iter()
        .filter_map(|e| e.ok())
        .filter(|f| f.file_type().is_file())
        .map(|f| f.into_path())
        .collect();

    let mut testcases: HashMap<String, Sysy> = HashMap::new();

    for file in source_file {
        let key = file
            .with_extension("")
            .file_name()
            .unwrap()
            .to_str()
            .unwrap()
            .to_string();

        match testcases.get_mut(&key) {
            Some(sysy) => {
                if file.extension().unwrap() == "sy" {
                    sysy.source = Some(file);
                } else if file.extension().unwrap() == "in" {
                    sysy.std_in = Some(file);
                } else if file.extension().unwrap() == "out" {
                    sysy.std_out = Some(file);
                }
            }
            None => {
                let mut sysy = Sysy {
                    name: key.clone(),
                    source: None,
                    std_in: None,
                    std_out: None,
                };

                if file.extension().unwrap() == "sy" {
                    sysy.source = Some(file);
                } else if file.extension().unwrap() == "in" {
                    sysy.std_in = Some(file);
                } else if file.extension().unwrap() == "out" {
                    sysy.std_out = Some(file);
                }

                testcases.insert(key, sysy);
            }
        }
    }

    let _ = testcases.par_iter().for_each(|(_, sysy)| perf(sysy));
}
