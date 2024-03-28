###### 交叉编译ARM纯净版脚本

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

5、执行

```shell
# 复制libc so
./build.sh init
# 编译依赖库
./build.sh libs
# 编译rts
./build.sh rts
```
