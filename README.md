###### 交叉编译ARM纯净

**1、下载FreeSWITCH源代码**

```shell
cd /usr/src
git clone https://github.com/rts-cn/rts.git
```

2、下载依赖库

```shell
cd /usr/src/lib
/usr/src/arm_build/get_lib.sh
git clone https://github.com/freeswitch/sofia-sip.git
git clone https://github.com/freeswitch/spandsp.git
```

3、下载编译器

```shell
cd /usr/src/arm_build
./get_linaro_gnueabihf.sh
```

4、修改build.sh 指定编译平台

```shell
# 编译目标平台
ARCH=arm-linux-gnueabihf
# 编译器路径
BUILDROOT=/usr/src/bin/gcc-linaro-6.3.1-2017.02-x86_64_$ARCH
# 编译器提供的SYSROOT
SYSROOT=/usr/src/bin/sysroot-glibc-linaro-2.23-2017.02-$ARCH
# 输出目录
OUT=/data/rts
# FreeSWITCH安装目录
FREESWITCH_PREFIX=/data/rts/freeswitch
# DYNAMIC_LINKER 
DYNAMIC_LINKER=$OUT/lib/ld-linux-armhf.so.3
```

5、执行

```
# 复制libc文件到out
./build.sh init
# 编译依赖库
./build.sh libs
# 编译rts
./build.sh rts
```
