#!/usr/bin/env python3
"""
Compare vectorization differences between clang and Gnalc.
It is aimed to find missing vectorization opportunities in our compiler.
"""

import os
import re
import subprocess
import argparse
from collections import defaultdict
import tempfile
import sys
import hashlib

def collect_sy(directory):
    sy_files = []
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.sy'):
                sy_files.append(os.path.join(root, file))
    return sy_files

def compile_to_ir(compiler, sy_file, output_file, is_clang=False):
    """
    Compile SY file to LLVM IR.
    For clang, first add necessary header declarations.
    """
    header = (
        "int getint(),getch(),getarray(int a[]);float getfloat();int getfarray(float a[]);"
        "void putint(int a),putch(int a),putarray(int n,int a[]);void putfloat(float a);"
        "void putfarray(int n, float a[]);void putf(char a[], ...);"
        "void _sysy_starttime(int);void _sysy_stoptime(int);"
        "typedef void (*Task)(int beg, int end); "
        "void gnalc_parallel_for(int beg, int end, Task task);\n"
        "#define starttime() _sysy_starttime(__LINE__)\n"
        "#define stoptime()  _sysy_stoptime(__LINE__)\n"
    )

    temp_path = None
    try:
        # For clang, create a temporary file with header prepended
        if is_clang:
            with open(sy_file, 'r') as f:
                original_content = f.read()

            fd, temp_path = tempfile.mkstemp(suffix='.sy')
            with os.fdopen(fd, 'w') as tmp:
                tmp.write(header + original_content)
            input_file = temp_path
        else:
            input_file = sy_file

        cmd = [
            compiler,
            '-O3' if is_clang else '-O1',
            '-emit-llvm',
            '-S',
            '-o', output_file,
            '-xc' if is_clang else '',
            input_file
        ]

        result = subprocess.run(cmd, capture_output=True, text=True)
        if result.returncode != 0:
            return False, result.stderr.strip() or "Compilation failed"
        return True, ""

    except Exception as e:
        return False, str(e)

    finally:
        # Clean up temporary file
        if temp_path and os.path.exists(temp_path):
            os.remove(temp_path)

def check_vectorization(ir_file):
    if not os.path.exists(ir_file):
        return False, f"IR file not found: {ir_file}"

    try:
        with open(ir_file, 'r') as f:
            content = f.read()
        # Regex pattern to match vector types in IR
        pattern = r'<\d+ x (i\d+|float|double|fp\d+)>'
        return True, bool(re.search(pattern, content))
    except Exception as e:
        return False, f"Error reading {ir_file}: {str(e)}"

def get_unique_file_id(sy_file, base_dir):
    """Generate unique ID for a file to avoid name conflicts"""
    rel_path = os.path.relpath(sy_file, base_dir)
    # Create hash of relative path to ensure uniqueness
    return hashlib.md5(rel_path.encode()).hexdigest()[:8]

def main():
    parser = argparse.ArgumentParser(description='Compare vectorization between clang and Gnalc')
    parser.add_argument('directory', help='Directory to scan for sy files')
    parser.add_argument('--gnalc', default='./gnalc', help='Path to custom compiler (default: ./gnalc)')
    parser.add_argument('--keep-ir', action='store_true', help='Keep intermediate IR files for debugging')
    args = parser.parse_args()

    sy_files = collect_sy(args.directory)
    if not sy_files:
        print("No SysY files found in directory")
        return

    # Create a temporary directory for IR files
    temp_dir = tempfile.mkdtemp(prefix="vec_compare_")
    print(f"Using temporary directory for IR files: {temp_dir}")

    results = []
    compiler_stats = defaultdict(int)
    total_files = len(sy_files)
    processed_count = 0

    for sy_file in sy_files:
        processed_count += 1
        file_id = get_unique_file_id(sy_file, args.directory)
        print(f"\nProcessing [{processed_count}/{total_files}]: {sy_file} [{file_id}]")

        # Create IR file paths in temp directory
        clang_ir = os.path.join(temp_dir, f"{file_id}_clang.ll")
        gnalc_ir = os.path.join(temp_dir, f"{file_id}_gnalc.ll")

        # Compile with clang (with header injection)
        print("  Compiling with clang...")
        clang_success, clang_error = compile_to_ir('clang', sy_file, clang_ir, is_clang=True)
        if not clang_success:
            print(f"  ! clang compilation failed: {clang_error}")
            compiler_stats['clang_fail'] += 1
            continue

        # Compile with gnalc
        print("  Compiling with gnalc...")
        gnalc_success, gnalc_error = compile_to_ir(args.gnalc, sy_file, gnalc_ir)
        if not gnalc_success:
            print(f"  ! gnalc compilation failed: {gnalc_error}")
            compiler_stats['gnalc_fail'] += 1
            # Clean up clang IR only if we're not keeping files
            if not args.keep_ir and os.path.exists(clang_ir):
                os.remove(clang_ir)
            continue

        # Check vectorization results
        print("  Checking vectorization...")
        clang_exists, clang_vec = check_vectorization(clang_ir)
        gnalc_exists, gnalc_vec = check_vectorization(gnalc_ir)

        if not clang_exists or not gnalc_exists:
            print(f"  ! Vectorization check failed: clang={clang_exists}, gnalc={gnalc_exists}")
            compiler_stats['check_fail'] += 1
            if not args.keep_ir:
                if os.path.exists(clang_ir):
                    os.remove(clang_ir)
                if os.path.exists(gnalc_ir):
                    os.remove(gnalc_ir)
            continue

        # Record comparison results
        status = "Match"
        if clang_vec and not gnalc_vec:
            status = "clang_vectorized_but_gnalc_not"
            compiler_stats['miss_clang'] += 1
        elif not clang_vec and gnalc_vec:
            status = "gnalc_vectorized_but_clang_not"
            compiler_stats['miss_gnalc'] += 1
        else:
            if clang_vec:
                compiler_stats['both_vectorized'] += 1
            else:
                compiler_stats['neither_vectorized'] += 1
            status = "Match"

        results.append({
            'file': sy_file,
            'clang_vectorized': clang_vec,
            'gnalc_vectorized': gnalc_vec,
            'status': status,
            'clang_ir': clang_ir,
            'gnalc_ir': gnalc_ir
        })

        print(f"  Result: {status.replace('_', ' ')}")

        # Clean up temporary IR files unless requested to keep
        if not args.keep_ir:
            if os.path.exists(clang_ir):
                os.remove(clang_ir)
            if os.path.exists(gnalc_ir):
                os.remove(gnalc_ir)

    # Print summary
    print("\n" + "="*50)
    print("===== Summary =====")
    print(f"Total SysY files processed: {total_files}")
    print(f"Successfully processed: {len(results)}")
    print(f"clang compilation failures: {compiler_stats['clang_fail']}")
    print(f"gnalc compilation failures: {compiler_stats['gnalc_fail']}")
    print(f"Vectorization check failures: {compiler_stats.get('check_fail', 0)}")

    if len(results) > 0:
        print("\nVectorization Results:")
        print(f"  Both vectorized: {compiler_stats.get('both_vectorized', 0)}")
        print(f"  Neither vectorized: {compiler_stats.get('neither_vectorized', 0)}")
        print(f"  ONLY clang vectorized: {compiler_stats['miss_clang']}")
        print(f"  ONLY gnalc vectorized: {compiler_stats['miss_gnalc']}")

        # Detailed report for mismatches
        if compiler_stats['miss_clang'] > 0 or compiler_stats['miss_gnalc'] > 0:
            print("\nFiles with optimization mismatches:")
            for res in results:
                if 'miss' in res['status']:
                    print(f"- {res['file']}: {res['status'].replace('_', ' ')}")
                    if args.keep_ir:
                        print(f"  clang IR: {res['clang_ir']}")
                        print(f"  gnalc IR: {res['gnalc_ir']}")
    else:
        print("\nNo files were successfully processed for vectorization comparison.")

    # Clean up temporary directory if empty
    if not args.keep_ir:
        try:
            if os.path.exists(temp_dir) and not os.listdir(temp_dir):
                os.rmdir(temp_dir)
                print(f"\nTemporary directory {temp_dir} removed")
            elif os.path.exists(temp_dir):
                print(f"\nTemporary directory {temp_dir} is not empty and will be kept")
        except Exception as e:
            print(f"Error cleaning up temporary directory: {str(e)}")
    else:
        print(f"\nIntermediate IR files kept in: {temp_dir}")

if __name__ == "__main__":
    main()