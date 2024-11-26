## Deploy a Virtualized Raspberry Pi by Docker

- First pull and run the docker image.

```shell
sudo docker pull ghcr.io/matteocarnelos/dockerpi:latest
# Qemu 22 -> Container 22 -> Host 18279 
sudo docker run -itd -e QEMU_HOSTFWD="tcp::22-:22" -p 18279:22 ghcr.io/matteocarnelos/dockerpi pi2
sudo docker attach <Container ID>
```

Refer to [the original repo](https://github.com/matteocarnelos/dockerpi?tab=readme-ov-file#port-forwarding) for more
information about port forwarding and other supported machines.

Note that the default username is `pi` and password is `raspberry`.

- Once you entered the Raspberry Pi, change your password and set up SSH by `raspi-config`.

```shell
sudo raspi-config
```

- (Optional) Replace `/etc/apt/sources.list` with:

```
deb [arch=armhf] http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib rpi
deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib rpi
```

- (Optional) Replace `/etc/apt/sources.list.d/raspi.list` with:

```
deb http://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ buster main
```