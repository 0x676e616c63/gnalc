#!/usr/bin/env python3

import os
import subprocess
import sys

def get_git_root():
    result = subprocess.run(["git", "rev-parse", "--show-toplevel"], stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            text=True, check=True)
    return result.stdout.strip()


def do_format(all_paths, exclude_paths):
    all_files = []
    git_root = get_git_root()
    for curr_dir in all_paths:
        for root, _, files in os.walk(git_root + "/" + curr_dir):
            for file in files:
                if file not in exclude_paths and file.endswith((".cpp", ".hpp", ".c", ".h")):
                    all_files.append(os.path.join(root, file))

    # print("Files to format: {}".format(all_files))
    command = ["clang-format", "-i"] + all_files
    result = subprocess.run(command, stderr=subprocess.PIPE)

    if result.returncode == 0:
        print("Success")
    else:
        print("Error:")
        print(result.stderr.decode())
        sys.exit(1)


if __name__ == "__main__":
    do_format(["tools", "test", "lib", "include"], ["lexer.cpp", "parser.cpp"])
