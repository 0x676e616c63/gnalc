#!/usr/bin/env python3

import argparse
import os
import subprocess
import sys
import glob

def main():
    parser = argparse.ArgumentParser(description='Generate CFG PNGs from LLVM IR file using new pass manager')
    parser.add_argument('input', help='Input LLVM IR (.ll) file')
    parser.add_argument('-o', '--output-dir', default='.', help='Output directory (default: current directory)')
    args = parser.parse_args()

    # 验证输入文件存在
    if not os.path.isfile(args.input):
        print(f"Error: Input file '{args.input}' not found", file=sys.stderr)
        sys.exit(1)

    # 创建输出目录
    os.makedirs(args.output_dir, exist_ok=True)

    # 生成CFG dot文件
    try:
        subprocess.run(
            ['opt', '-disable-output', '--passes=dot-cfg', args.input],
            check=True,
            capture_output=True,
            text=True
        )
    except subprocess.CalledProcessError as e:
        print(f"Error generating CFG:\n{e.stderr}", file=sys.stderr)
        sys.exit(1)
    except FileNotFoundError:
        print("Error: 'opt' command not found. Ensure LLVM is installed and in PATH", file=sys.stderr)
        sys.exit(1)

    # 查找生成的dot文件
    dot_files = glob.glob('.*.dot')
    # 检查是否生成有效的dot文件
    if not dot_files:
        print("No CFG dot files generated. Possible reasons:", file=sys.stderr)
        print("1. Input file contains no functions")
        print("2. LLVM version does not support new pass manager")
        sys.exit(1)

    # 验证dot命令可用性
    try:
        subprocess.run(
            ['dot', '-V'],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
    except (subprocess.CalledProcessError, FileNotFoundError):
        print("Error: 'dot' command not found. Install Graphviz", file=sys.stderr)
        # 清理dot文件
        for df in dot_files:
            os.remove(df)
        sys.exit(1)

    # 处理每个dot文件
    success_count = 0
    for dot_file in dot_files:
        if not (dot_file.startswith('.') and dot_file.endswith('.dot')):
            os.remove(dot_file)
            continue

        # 从文件名中提取函数名
        function_name = dot_file[1:-4]
        output_file = os.path.join(args.output_dir, f"{function_name}.cfg.png")

        try:
            # 生成PNG
            subprocess.run(
                ['dot', '-Tpng', dot_file, '-o', output_file],
                check=True,
                capture_output=True,
                text=True
            )
            success_count += 1
            print(f"Generated {output_file}")
        except subprocess.CalledProcessError as e:
            print(f"Error processing {dot_file}:\n{e.stderr}", file=sys.stderr)
        finally:
            # 清理临时文件
            os.remove(dot_file)

    print(f"\nSuccessfully generated {success_count}/{len(dot_files)} CFG diagrams")
    if success_count < len(dot_files):
        sys.exit(1)

if __name__ == '__main__':
    main()