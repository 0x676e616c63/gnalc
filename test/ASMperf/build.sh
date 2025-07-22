#!/bin/bash

build_mode=$1

if [ ! -d "../ASMperf_result" ]; then
    mkdir -p ../ASMperf_result/
fi

if [[ $build_mode == "debug" ]]; then
    cargo build
    cp ./target/debug/ASMperf ../ASMperf_result/.
else
    cargo build --release
    cp ./target/release/ASMperf ../ASMperf_result/.
fi



