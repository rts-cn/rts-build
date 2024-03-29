#!/bin/bash
# 下载编译器 gnueabihf
if [ ! -f "gcc-linaro-6.3.1-2017.02-x86_64_arm-linux-gnueabihf.tar" ];then
    wget https://releases.linaro.org/components/toolchain/binaries/6.3-2017.02/arm-linux-gnueabihf/gcc-linaro-6.3.1-2017.02-x86_64_arm-linux-gnueabihf.tar.xz
    xz -d gcc-linaro-6.3.1-2017.02-x86_64_arm-linux-gnueabihf.tar.xz && \
    tar xvf gcc-linaro-6.3.1-2017.02-x86_64_arm-linux-gnueabihf.tar;
fi

if [ ! -f "sysroot-glibc-linaro-2.23-2017.02-arm-linux-gnueabihf.tar.xz" ];then
    wget https://releases.linaro.org/components/toolchain/binaries/6.3-2017.02/arm-linux-gnueabihf/sysroot-glibc-linaro-2.23-2017.02-arm-linux-gnueabihf.tar.xz
    xz -d sysroot-glibc-linaro-2.23-2017.02-arm-linux-gnueabihf.tar.xz
    tar xvf sysroot-glibc-linaro-2.23-2017.02-arm-linux-gnueabihf.tar
fi
