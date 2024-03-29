# 交叉编译ARM纯净版脚本

实现了最基础模块的编译

## 编译环境Dockerfile

```m

FROM debian:bullseye-slim as rts-build
LABEL maintainer="ZhuBo <ZhuBo@rts.cn>"

RUN apt-get update 
RUN apt-get install -y \
  --no-install-recommends --no-install-suggests \
  ca-certificates curl locales bison \
  automake autoconf get curl \
  perl pkg-config swig valgrind gnupg2 \
  cmake git tig htop procps gdb vim ngrep python3-dev libltdl-dev gawk rsync openssh-client zlib1g 

RUN ldconfig

WORKDIR /usr/src/

```

## 下载RTS源代码

```shell
cd /usr/src
git clone https://github.com/rts-cn/rts.git
```

## 下载依赖库

```shell
cd /usr/src/lib 
git clone https://github.com/freeswitch/sofia-sip.git
git clone https://github.com/freeswitch/spandsp.git
/usr/src/arm_build/get_lib.sh
```

## 下载编译器

```shell
cd /usr/src/arm_build
./get_linaro_gnueabihf.sh
```

## 编译

### 初始化基础环境

初始化基础环境，复制libc相关so到OUT目录

```shell
./build.sh init
```

### 编译依赖库

```shell
./build.sh libs
```

### 编译RTS

```shell
./build.sh rts
```
