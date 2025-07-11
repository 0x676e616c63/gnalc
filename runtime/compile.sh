#!/bin/bash

# This script should be run by CMake.
# If you want to run it manually, you can run it like this:
# ./compile.sh [output_dir] [--debug] [cpp_file]

OUTPUT_DIR="${1:-./artifacts}"
DEBUG_FLAG="${2:-}"

CLANG_FLAGS="-O3 -S -emit-llvm"
CPP_FILE="${3:-./thread.cpp}"

mkdir -p "$OUTPUT_DIR"

OUTPUT_LL_FILE="$OUTPUT_DIR/thread.ll"
OUTPUT_FILE="$OUTPUT_DIR/thread.ll.hpp"

if [[ "$DEBUG_FLAG" == "--debug" ]]; then
    CLANG_FLAGS="$CLANG_FLAGS -DGNALC_DEBUG"
fi

mkdir -p "$(dirname "$OUTPUT_FILE")"
clang++ $CLANG_FLAGS "$CPP_FILE" -o "$OUTPUT_LL_FILE"

sed -i '/^source_filename/d' "$OUTPUT_LL_FILE"
sed -i '/^target datalayout/d' "$OUTPUT_LL_FILE"
sed -i '/^target triple/d' "$OUTPUT_LL_FILE"

xxd -i -n gnalc_thread_runtime "$OUTPUT_LL_FILE" "$OUTPUT_FILE"
