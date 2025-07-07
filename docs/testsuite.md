# Gnalc Test/Benchmark Suite

### Test Data

First update `contest` submodule

```shell
git submodule init
git submodule update
```

Alternatively, you can download it from [here](https://github.com/caozhanhao/gnalc-test-data/releases), and extract it
to `test/contest`.

### QEMU Installation

#### Compile

```shell
# if ubuntu
sudo apt install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev \
              gawk build-essential bison flex texinfo gperf libtool patchutils bc \
              zlib1g-dev libexpat-dev pkg-config  libglib2.0-dev libpixman-1-dev libsdl2-dev libslirp-dev \
              git tmux python3 python3-pip ninja-build
```

##### ARMv7

```shell
wget https://download.qemu.org/qemu-9.2.0.tar.xz
tar xvJf qemu-9.2.0.tar.xz
cd qemu-9.2.0
./configure --target-list=arm-linux-user
make -j$(nproc)
```

##### AArch64

```shell
wget https://download.qemu.org/qemu-9.2.3.tar.xz
tar xvJf qemu-9.2.3.tar.xz
cd qemu-9.2.3
./configure --target-list=aarch64-linux-user
make -j$(nproc)
# 9.2.0 can't compile with `redefinition of 'struct sched_attr'`
```

#### Environment

To avoid conflicts, use environment variable rather than `sudo make install`.

##### bash

```shell
vim ~/.bashrc
```

And add the next line.

```shell
export PATH=$PATH:<your-path>/qemu-<your-version>/build
```

##### fish

```shell
vim ~/.config/fish/config.fish
```

Edit the config like this.

```shell
if status is-interactive
    # Commands to run in interactive sessions can go here
    set PATH <your-path>/qemu-<your-version>/build $PATH
end
```

#### After Installation

Restart the shell and use `qemu-arm --version` to confirm the version.

```
qemu-arm version 9.2.0
Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
```

### GCC

#### Ubuntu

###### ARMv7

```shell
sudo apt install gcc-14-arm-linux-gnueabi
# setup ld for qemu-arm
sudo ln -s /usr/arm-linux-gnueabi/lib/ld-linux.so.3 /lib/ld-linux.so.3
```

###### AArch64

```shell
sudo apt install gcc-aarch64-linux-gnu
# setup ld for qemu-arm
sudo ln -s /usr/aarch64-linux-gnu/lib/ld-linux-aarch64.so.1 /lib/ld-linux-aarch64.so.1
```

#### Arch/Manjaro

###### ARMv7

```shell
paru -S arm-linux-gnueabihf-gcc14-linaro-bin
# setup ld for qemu-arm
sudo ln -s /usr/arm-linux-gnueabihf/libc/lib/ld-linux-armhf.so.3 /lib/ld-linux-armhf.so.3
```

###### AArch64

```shell
sudo pacman -S aarch64-linux-gnu-gcc
# setup ld for qemu-aarch64
sudo ln -s /usr/aarch64-linux-gnu/lib/ld-linux-aarch64.so.1 /lib/ld-linux-aarch64.so.1
```

#### Fedora 42

###### AArch64

```shell
sudo dnf install binutils-aarch64-linux-gnu.x86_64 
sudo dnf install gcc-aarch64-linux-gnu.x86_64 
sudo dnf install sysroot-aarch64-fc42-glibc.noarch
# check path of sysroot
rpm -ql sysroot-aarch64-fc42-glibc
# it suppose to be: /usr/aarch64-redhat-linux/sys-root/fc42 ...
```

### Setup Environment Variables

To let `gnalc_test` and `pass_benchmark` know your installation, set the environment variables.

| Variable                      | Description                               | Fallback Value                                                                                         |
|-------------------------------|-------------------------------------------|--------------------------------------------------------------------------------------------------------|
| GNALC_TEST_GCC_AARCH64        | gcc for aarch64                           | `aarch64-linux-gnu-gcc --sysroot=/usr/aarch64-redhat-linux/sys-root/fc42` or `gcc` on aarch64          |
| GNALC_TEST_QEMU_AARCH64       | qemu-arm for aarch64                      | `qemu-aarch64 -cpu cortex-a53 -L /usr/aarch64-redhat-linux/sys-root/fc42/usr/` or `<empty>` on aarch64 |
| GNALC_TEST_GNALC              | path to gnalc                             | `../gnalc`                                                                                             |
| GNALC_TEST_TEST_DATA          | path to test data                         | `../../test/contest`                                                                                   |
| GNALC_TEST_SYLIBC             | path to sylibc                            | `../../test/sylib/sylib.c`                                                                             |
| GNALC_TEST_TEST_TEMP_DIR      | path to temporary directory               | `./gnalc_test_temp`                                                                                    |
| GNALC_TEST_BENCHMARK_TEMP_DIR | path to temporary directory for benchmark | `./gnalc_benchmark_temp`                                                                               |

Alternatively, though not recommended, you can edit the fallback value of `gcc_arm_command` and `qemu_arm_command`
manually in [config.cpp](../test/config.cpp) according to your
machine.

#### Common config

If you are following the installation steps above, maybe you can use our config directly.

##### Fedora
the Fallback value.
##### Ubuntu & Manjaro
- `GNALC_TEST_GCC_AARCH64`: `aarch64-linux-gnu-gcc-13`
- `GNALC_TEST_QEMU_AARCH64`: `LD_LIBRARY_PATH=/usr/aarch64-linux-gnu/lib qemu-aarch64`