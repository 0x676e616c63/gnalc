#!/usr/bin/env python3
# Copyright (c) 2025 0x676e616c63
# SPDX-License-Identifier: MIT
import argparse
import os
import re
import shutil
import subprocess
from datetime import datetime
from zoneinfo import ZoneInfo


def get_git_root():
    result = subprocess.run(["git", "rev-parse", "--show-toplevel"], stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            text=True, check=True)
    return result.stdout.strip()


def get_git_info(git_root):
    branch = subprocess.run(
        ["git", "rev-parse", "--abbrev-ref", "HEAD"],
        cwd=git_root,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        check=True
    ).stdout.strip()
    sha = subprocess.run(
        ["git", "rev-parse", "HEAD"],
        cwd=git_root,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        check=True
    ).stdout.strip()
    commit_msg = subprocess.run(
        ["git", "log", "-1", "--format=%s", sha],
        cwd=git_root,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        check=True
    ).stdout.strip()
    return branch, sha, commit_msg


def copy_to_submit(git_root, arch):
    submit_temp = os.path.join(git_root, "educg", "submit_temp")

    if os.path.exists(submit_temp):
        print(f"Removed: {submit_temp}")
        shutil.rmtree(submit_temp)

    os.makedirs(submit_temp)

    license_path = os.path.join(git_root, "LICENSE")
    include_dir = os.path.join(git_root, "include")
    lib_dir = os.path.join(git_root, "lib")
    runtime_artifacts_dir = os.path.join(git_root, "runtime", "artifacts")
    driver_cpp = os.path.join(git_root, "educg", "educg_driver.cpp")
    driver_header_name = f"educg_{arch}_driver.hpp"
    driver_header_src = os.path.join(git_root, "educg", driver_header_name)

    if not os.path.exists(license_path):
        raise FileNotFoundError(f"license not found: {license_path}")
    if not os.path.exists(include_dir):
        raise FileNotFoundError(f"include not found: {include_dir}")
    if not os.path.exists(lib_dir):
        raise FileNotFoundError(f"lib not found: {lib_dir}")
    if not os.path.exists(runtime_artifacts_dir):
        raise FileNotFoundError(f"lib not found: {runtime_artifacts_dir}")
    if not os.path.exists(driver_cpp):
        raise FileNotFoundError(f"driver.cpp not found: {driver_cpp}")
    if not os.path.exists(driver_header_src):
        raise FileNotFoundError(f"{driver_header_name} not found: {driver_header_src}")

    print(f"Copying {license_path} -> {os.path.join(submit_temp, 'LICENSE')}")
    shutil.copy(license_path, os.path.join(submit_temp, "LICENSE"))
    print(f"Copying {include_dir} -> {os.path.join(submit_temp, "include")}")
    shutil.copytree(include_dir, os.path.join(submit_temp, "include"))
    print(f"Copying {lib_dir} -> {os.path.join(submit_temp, "lib")}")
    shutil.copytree(lib_dir, os.path.join(submit_temp, "lib"))
    print(f"Copying {runtime_artifacts_dir} -> {os.path.join(submit_temp, "runtime", "artifacts")}")
    shutil.copytree(runtime_artifacts_dir, os.path.join(submit_temp, "runtime", "artifacts"))
    print(f"Copying {driver_cpp} -> {os.path.join(submit_temp, 'driver.cpp')}")
    shutil.copy(driver_cpp, os.path.join(submit_temp, "driver.cpp"))
    print(f"Copying {driver_header_src} -> {os.path.join(submit_temp, "driver.hpp")}")
    shutil.copy(driver_header_src, os.path.join(submit_temp, "driver.hpp"))

    return submit_temp


def rewrite_includes(submit_dir):
    include_dir = os.path.join(submit_dir, "include")
    rewrite_dirs = ['codegen', 'config', 'ggc', 'graph', 'ir', 'mir', 'legacy_mir',
                    'parser', 'pass_manager', 'match', 'sir', 'utils', 'runtime', 'constraint']

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


def generate_readme(submit_dir, branch, sha, original_msg, arch):
    readme_path = os.path.join(submit_dir, "README.md")
    now = datetime.now(ZoneInfo('Asia/Shanghai')).strftime('%Y-%m-%d %H:%M:%S')
    contents = [
        f"# 0x676e616c63 - gnalc {arch}",
        "",
        f"- Sync on: {now}",
        f"- Source Branch: {branch}",
        f"- Source Commit SHA: {sha}",
        f"- Source Commit Message: {original_msg}",
    ]

    with open(readme_path, 'w', encoding='utf-8') as f:
        f.write("\n".join(contents))
    print(f"Generated README at: {readme_path}")


def checkout_and_commit(temp_dir, original_msg, arch):
    parent_dir = os.path.dirname(temp_dir)
    final_dir = os.path.join(parent_dir, 'submit')
    branch = f"{arch}-submit"

    subprocess.run(["git", "checkout", branch], cwd=parent_dir, check=True)
    print(f"Checked out branch: {branch}")

    if os.path.exists(final_dir):
        shutil.rmtree(final_dir)
    os.rename(temp_dir, final_dir)
    print(f"Renamed {temp_dir} to {final_dir}")

    subprocess.run(["git", "add", "submit"], cwd=parent_dir, check=True)
    status = subprocess.run([
        "git", "diff", "--cached", "--quiet", "--", ".", ":(exclude)submit/README.md"
    ], cwd=parent_dir)
    if status.returncode == 0:
        print("No changes to commit.")
    else:
        now = datetime.now(ZoneInfo('Asia/Shanghai')).strftime('%Y-%m-%d %H:%M:%S')
        commit_msg = f"Sync for {arch} at {now}. ({original_msg})"
        subprocess.run(
            ["git", "commit", "-m", commit_msg],
            cwd=parent_dir,
            check=True
        )
        print("Committed submission updates.")


def main():
    parser = argparse.ArgumentParser(description="Prepare submission directory for gnalc")
    parser.add_argument('--arch', choices=['arm', 'riscv'], required=True,
                        help='Target architecture for driver header')
    args = parser.parse_args()

    git_root = get_git_root()
    print(f"Git Root: {git_root}")

    original_branch, sha, original_msg = get_git_info(git_root)
    print(f"Original Branch: {original_branch}, SHA: {sha}")

    temp_dir = copy_to_submit(git_root, args.arch)
    print(f"Submit Temo Dir: {temp_dir}")

    rewrite_includes(temp_dir)
    print("Includes rewritten")

    generate_readme(temp_dir, original_branch, sha, original_msg, args.arch)
    print("README generated")

    checkout_and_commit(temp_dir, original_msg, args.arch)

    subprocess.run(["git", "checkout", "-f", original_branch], cwd=git_root, check=True)
    print(f"Checked out original branch: {original_branch}")


if __name__ == "__main__":
    main()
