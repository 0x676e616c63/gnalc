#!/bin/bash

CLANG_FLAGS="-O3 -S -emit-llvm"
CPP_FILE="./thread.cpp"
OUTPUT_FILE="./artifacts/thread.ll.hpp"

if [[ "$1" == "--debug" ]]; then
    CLANG_FLAGS="$CLANG_FLAGS -DGNALC_DEBUG"
fi

mkdir -p "$(dirname "$OUTPUT_FILE")"
clang $CLANG_FLAGS "$CPP_FILE" -o "$OUTPUT_FILE"

sed -i '/^source_filename/d' "$OUTPUT_FILE"
sed -i '/^target datalayout/d' "$OUTPUT_FILE"
sed -i '/^target triple/d' "$OUTPUT_FILE"

CONTENT=$(cat "$OUTPUT_FILE")
printf 'R"(\n%s\n)"\n' "$CONTENT" > "$OUTPUT_FILE"

