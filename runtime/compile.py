#!/usr/bin/env python3
import argparse
import os
import subprocess


def run(cmd, **kwargs):
    print(f"Running: {' '.join(cmd)}")
    result = subprocess.run(cmd, check=True, **kwargs)
    return result


def filter_ll_file(path):
    filtered_lines = []
    with open(path, 'r') as f:
        for line in f:
            if line.startswith(('source_filename', 'target datalayout', 'target triple')):
                continue
            filtered_lines.append(line)
    with open(path, 'w') as f:
        f.writelines(filtered_lines)


def embed_with_xxd(input_file, output_header, var_name):
    run(['xxd', '-i', '-n', var_name, input_file, output_header])


def main():
    parser = argparse.ArgumentParser(description='Compile and embed thread runtime code')
    parser.add_argument('output_dir', nargs='?', default='./artifacts',
                        help='Directory for output files')
    parser.add_argument('--debug', action='store_true',
                        help='Enable debug compilation flag')
    parser.add_argument('cpp_file', nargs='?', default='./thread.cpp',
                        help='C++ source file to compile')
    args = parser.parse_args()

    out = args.output_dir
    os.makedirs(out, exist_ok=True)

    dbg_flags = ['-O3']
    if args.debug:
        dbg_flags.append('-DGNALC_DEBUG')

    ll = os.path.join(out, 'thread.ll')
    asm_armv8_s = os.path.join(out, 'thread.armv8.s')
    # asm_riscv64_s = os.path.join(out, 'thread.riscv64.s')
    ll_cpp = ll + '.cpp'
    asm_armv8_cpp = asm_armv8_s + '.cpp'
    # asm_riscv64_cpp = asm_riscv64_s + '.cpp'

    run(['clang++', '-O3', '-DNDEBUG', '-S', *dbg_flags, '-emit-llvm', args.cpp_file, '-o', ll])
    run(['aarch64-linux-gnu-g++', '-O3', '-DNDEBUG', '-march=armv8-a', '-fno-stack-protector', '-fomit-frame-pointer',
         '-mcpu=cortex-a53', '-ffp-contract=on', '-no-pie', '-S', *dbg_flags, args.cpp_file, '-o', asm_armv8_s])
    # run(['riscv64-linux-gnu-g++', '-S', *dbg_flags, args.cpp_file, '-o', asm_riscv64_s])

    filter_ll_file(ll)

    embed_with_xxd(ll, ll_cpp, 'gnalc_thread_runtime_ll')
    embed_with_xxd(asm_armv8_s, asm_armv8_cpp, 'gnalc_thread_runtime_armv8_s')
    # embed_with_xxd(asm_riscv64_s, asm_riscv64_cpp, 'gnalc_thread_runtime_riscv64_s')

    print('Done.')


if __name__ == '__main__':
    main()
