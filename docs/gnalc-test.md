### Test Data
First update `gnalc-test-data` submodule
```shell
git submodule init
git submodule update
sudo apt install git-lfs
cd test/gnalc-test-data
git lfs install
git lfs pull
```

### QEMU Installation

#### Compile
```shell
# if ubuntu
sudo apt install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev \
              gawk build-essential bison flex texinfo gperf libtool patchutils bc \
              zlib1g-dev libexpat-dev pkg-config  libglib2.0-dev libpixman-1-dev libsdl2-dev libslirp-dev \
              git tmux python3 python3-pip ninja-build
```
```shell
wget https://download.qemu.org/qemu-9.2.0.tar.xz
tar xvJf qemu-9.2.0.tar.xz
cd qemu-9.2.0
./configure --target-list=arm-linux-user
make -j$(nproc)
```

#### Environment
To avoid conflicts, use environment variable rather than `sudo make install`.

##### bash
```shell
vim ~/.bashrc
```
And add the next line.
```shell
export PATH=$PATH:<your-path>/qemu-9.2.0/build
```

##### fish
```shell
vim ~/.config/fish/config.fish
```
Edit the config like this.
```shell
if status is-interactive
    # Commands to run in interactive sessions can go here
    set PATH <your-path>/qemu-9.2.0/build $PATH
end
```

#### After Installation
Restart the shell and use `qemu-arm --version` to confirm the version.
```
qemu-arm version 9.2.0
Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
```

### GCC
```shell
sudo apt install gcc-14-arm-linux-gnueabi
# setup ld for qemu-arm
sudo ln -s /usr/arm-linux-gnueabi/lib/ld-linux.so.3 /lib/ld-linux.so.3
```

Then edit `gcc_arm_command` and `qemu_arm_command` in [gnalc_test.cpp](../test/gnalc_test.cpp) according to your machine.
```c++
const std::string gcc_arm_command = "arm-linux-gnueabi-gcc-14";
const std::string qemu_arm_command = "LD_LIBRARY_PATH=/usr/arm-linux-gnueabi/lib qemu-arm";
```
