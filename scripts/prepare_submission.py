#!/usr/bin/env python3
# Copyright (c) 2025 0x676e616c63
# SPDX-License-Identifier: MIT

import os
import re
import shutil
import subprocess


def get_git_root():
    result = subprocess.run(["git", "rev-parse", "--show-toplevel"], stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            text=True, check=True)
    return result.stdout.strip()


def copy_to_submit(git_root):
    submit_dir = os.path.join(git_root, "submit")

    if os.path.exists(submit_dir):
        print(f"Removed: {submit_dir}")
        shutil.rmtree(submit_dir)

    os.makedirs(submit_dir)

    include_dir = os.path.join(git_root, "include")
    lib_dir = os.path.join(git_root, "lib")
    driver_cpp = os.path.join(git_root, "tools", "driver", "driver.cpp")
    loong_txt = os.path.join(git_root, "tools", "driver", "loong.txt")

    if not os.path.exists(include_dir):
        raise FileNotFoundError(f"include not found: {include_dir}")
    if not os.path.exists(lib_dir):
        raise FileNotFoundError(f"lib not found: {lib_dir}")
    if not os.path.exists(driver_cpp):
        raise FileNotFoundError(f"driver.cpp not found: {driver_cpp}")

    print(f"Copying {include_dir} -> {os.path.join(submit_dir, 'include')}")
    shutil.copytree(include_dir, os.path.join(submit_dir, "include"))
    print(f"Copying {lib_dir} -> {os.path.join(submit_dir, 'lib')}")
    shutil.copytree(lib_dir, os.path.join(submit_dir, "lib"))
    print(f"Copying {driver_cpp} -> {os.path.join(submit_dir, 'driver.cpp')}")
    shutil.copy(driver_cpp, os.path.join(submit_dir, "driver.cpp"))
    print(f"Copying {loong_txt} -> {os.path.join(submit_dir, 'loong.txt')}")
    shutil.copy(loong_txt, os.path.join(submit_dir, "loong.txt"))

    return submit_dir


def rewrite_includes(submit_dir):
    include_dir = os.path.join(submit_dir, "include")
    rewrite_dirs = ['codegen', 'config', 'ggc', 'graph', 'ir', 'mir', 'legacy_mir',
                    'parser', 'pass_manager', 'match', 'sir', 'utils']

    def process_file(file_path):
        print(f"Processing file: {file_path}")
        with open(file_path, "r", encoding="utf-8") as f:
            content = f.read()

        def replace_include(match):
            include_type = match.group(1)  # < or "
            include_path = match.group(2)
            include_end = match.group(3)

            for dir_name in rewrite_dirs:
                if include_path.startswith(f"{dir_name}/") or include_path == dir_name:
                    relative_path = os.path.relpath(
                        os.path.join(include_dir, include_path),
                        os.path.dirname(file_path)
                    ).replace("\\", "/")
                    return f"#include {include_type}{relative_path}{include_end}"

            return match.group(0)

        new_content = re.sub(
            r'#include\s*([<"])([^">]+)([>"])',
            replace_include,
            content
        )

        with open(file_path, "w", encoding="utf-8") as f:
            f.write(new_content)

    for root, dirs, files in os.walk(submit_dir):
        for file in files:
            if file.endswith((".cpp", ".hpp", ".c", ".h")):
                file_path = os.path.join(root, file)
                process_file(file_path)


def main():
    git_root = get_git_root()
    print(f"Git Root: {git_root}")

    submit_dir = copy_to_submit(git_root)
    print(f"Submit Dir: {submit_dir}")

    rewrite_includes(submit_dir)
    print("Includes rewritten")


if __name__ == "__main__":
    main()
