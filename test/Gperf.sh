#!/bin/bash

mode=$1
source_file_path=$2
opt_level=${@:3}
current_time=$(date +"%Y-%m-%d %H:%M:%S")
target_dir="perf.out_${current_time}"

if [ $# -lt 1 ] || [[ "$mode" == "-h" || "$mode" == "--help" ]]; then
    echo "Usage: ./Gperf.sh <mode> <source_file_path> <opt_level>"
    echo "mode: record, report, clean, or -h/--help"
    echo "source_file_path: path to the source file to be profiled"
    echo "opt_level: optimization level for the compiler (e.g., -O1, -emit-llc, etc.)"
    echo "eg: ./Gperf.sh record ./contest/functional/00_main.sy -O1 -emit-llc"
    exit 0
fi

if [[ "$mode" == "clean" ]]; then
    echo "Cleaning up perf data..."
    cd perf_result
    rm -rf *
    cd ..
    exit 0
fi

if [[ "${source_file_path:0:2}" == "./" ]]; then
    source_file_path="${source_file_path:2}"
fi

echo "profiling result is in perf_result dir"
cd perf_result
mkdir "${current_time}"
cd "${current_time}"
perf ${mode} -g -F 99 -- ../../gnalc -S "../../${source_file_path}" ${opt_level} -o "test.out"
perf script -i perf.data > perf.out
echo "perf script result is in 'perf.out'"
stackcollapse-perf.pl perf.out &> perf.folded
flamegraph.pl perf.folded > perf.svg
cp perf.svg /mnt/c/Users/30336/Desktop/perf.svg
cd ../..