#!/bin/bash
export ARCH=arm-linux-gnueabihf
export BUILD=/usr/src/arm_build/gcc-linaro-6.3.1-2017.02-x86_64_$ARCH
export SYS_ROOT=/usr/src/arm_build/sysroot-glibc-linaro-2.23-2017.02-$ARCH
export OUT=/data/rts
export FREESWITCH_PREFIX=$OUT/rts
export DYNAMIC_LINKER=$OUT/sys/lib/ld-linux-armhf.so.3

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$BUILD/bin"
export PKG_CONFIG_PATH="$OUT/sys/lib/pkgconfig"
export CFLAGS="-Wl,-rpath=$OUT/sys/lib,-dynamic-linker=$DYNAMIC_LINKER -I$OUT/sys/include"
export LDFLAGS="-L$OUT/sys/lib"

echo 
echo "***********************************************************"
echo `date`
echo PATH = $PATH
echo CFLAGS = $CFLAGS
echo LDFLAGS = $LDFLAGS
echo "***********************************************************"
echo

get_arch=`arch`
if ! [[  $get_arch =~ "x86_64" ]];then
    if ! [[ -f "/lib64/ld-linux-x86-64.so.2" ]]; then 
        echo "$get_arch"
        dpkg --add-architecture amd64
        apt-get update
        apt-get install -y zlib1g:amd64 libc6-dev:amd64
    fi
fi

INIT="init"
LIBS="openssl tiff zlib libjpeg sqlite3 curl pcre speex speexdsp uuid ncurses libedit"
FREESWITCH="sofia-sip spandsp freeswitch"
MODULES=""

ALL="$LIBS $FREESWITCH $MODULES"

ARGS=$@

if [[ "$1" == 'init' ]]; then
	ARGS=$INIT
elif [[ "$1" == 'rts' ]]; then
	ARGS=$FREESWITCH
elif [[ "$1" == 'libs' ]]; then
	ARGS=$LIBS
elif [[ "$1" == 'modules' ]]; then
	ARGS=$MODULES
fi

#build all parts without args
if [ $# = 0 ]; then ARGS=$ALL[@]; fi

echo building $ARGS

ModuleCheck() {
	if echo "$ARGS[@]" | grep -w "$1" &>/dev/null; then
		echo building $1
		return 0
	fi
	return 1
}

# copy libc
ModuleCheck 'init'
if [ $? -eq 0 ]; then
    rm  -f  $OUT/sys/lib/ld-linux-armhf.so*
    rm  -f  $OUT/sys/lib/libc.so* 
    rm  -f  $OUT/sys/lib/libcrypt.so*
    rm  -f  $OUT/sys/lib/libdl.so*
    rm  -f  $OUT/sys/lib/libgcc_s.so*
    rm  -f  $OUT/sys/lib/libm.so*
    rm  -f  $OUT/sys/lib/libpthread.so*
    rm  -f  $OUT/sys/lib/librt.so*
    rm  -f  $OUT/sys/lib/libstdc++.so*

    cp -u -v  $SYS_ROOT/lib/ld-linux-armhf.so* $OUT/sys/lib/
    cp -u -v  $SYS_ROOT/lib/libc.so*  $OUT/sys/lib/
    cp -u -v  $SYS_ROOT/lib/libcrypt.so*  $OUT/sys/lib/
    cp -u -v  $SYS_ROOT/lib/libdl.so*  $OUT/sys/lib/
    cp -u -v  $SYS_ROOT/lib/libgcc_s.so*  $OUT/sys/lib/
    cp -u -v  $SYS_ROOT/lib/libm.so* $OUT/sys/lib/
    cp -u -v  $SYS_ROOT/lib/libpthread.so*  $OUT/sys/lib/
    cp -u -v  $SYS_ROOT/lib/librt.so*  $OUT/sys/lib/
    cp -u -v  $SYS_ROOT/lib/libstdc++.so*  $OUT/sys/lib/
fi

# build openssl
ModuleCheck 'openssl'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/openssl-OpenSSL_1_1_1t && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./Configure --prefix=$OUT/sys --cross-compile-prefix=$ARCH- no-asm no-async shared linux-armv4; fi && make -j $(nproc --all) build_libs && make install_sw
fi

# build tiff
ModuleCheck 'tiff'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/tiff-4.0.10 && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./configure --host=$ARCH --prefix=$OUT/sys; fi && make -j $(nproc --all) && make install
fi

# build zlib
ModuleCheck 'zlib'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/zlib-1.3.1 && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then AR="$ARCH-ar" LD="$ARCH-gcc" CC="$ARCH-gcc" ./configure --prefix=$OUT/sys; fi && make -j $(nproc --all) && make install
fi

# build zlib
ModuleCheck 'libjpeg'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/libjpeg-turbo-3.0.2 && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then cmake . -DCMAKE_INSTALL_PREFIX=$OUT/sys -DCMAKE_BUILD_TYPE=RELEASE -DENABLE_STATIC=TRUE -DCMAKE_C_COMPILER=$ARCH-gcc -DCMAKE_SYSTEM_PROCESSOR=arm -DCMAKE_SYSTEM_NAME=Linux  -DCMAKE_C_FLAGS=-fPIC; fi && make -j $(nproc --all) && make install
fi

# build sqlite3
ModuleCheck 'sqlite3'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/sqlite-autoconf-3450200 && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./configure -host=$ARCH --prefix=$OUT/sys; fi && make -j $(nproc --all) && make install
fi

# build curl
ModuleCheck 'curl'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/curl-8.6.0 && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./configure --with-ssl --enable-shared --enable-static --with-zlib --disable-dict --disable-ftp --disable-imap --disable-ldap --disable-ldaps --disable-pop3 --disable-proxy --disable-rtsp --disable-smtp --disable-telnet --disable-tftp --without-ca-bundle --without-gnutls  --without-librtmp --without-libssh2 --without-libpsl --prefix=$OUT/sys --host=$ARCH; fi && make -j $(nproc --all) && make install
fi

# build pcre
ModuleCheck 'pcre'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/pcre-8.45 && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./configure --host=$ARCH --prefix=$OUT/sys; fi && make -j $(nproc --all) && make install
fi

# build speex
ModuleCheck 'speex'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/speex-1.2.1 && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./configure --host=$ARCH --prefix=$OUT/sys; fi && make -j $(nproc --all) && make install
fi

# build speex
ModuleCheck 'speexdsp'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/speexdsp-1.2.1 && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./configure --host=$ARCH --prefix=$OUT/sys; fi && make -j $(nproc --all) && make install
fi

# build uuid
ModuleCheck 'uuid'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/libuuid-1.0.3 && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./configure --host=$ARCH --prefix=$OUT/sys; fi && make -j $(nproc --all) && make install
fi

# build libedit
ModuleCheck 'ncurses'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/ncurses-6.4 && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./configure --host=$ARCH --prefix=$OUT/sys --without-cxx --without-cxx-binding --without-ada --without-manpages --enable-overwrite --without-debug --without-tests --with-shared --without-tests --without-progs; fi && make -j $(nproc --all) && make install
fi

# build libedit
ModuleCheck 'libedit'
if [ $? -eq 0 ]; then
    cd /usr/src/libs/libedit-20230828-3.1 && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./configure --host=$ARCH --prefix=$OUT/sys; fi && make -j $(nproc --all) && make install
fi

# build sofia-sip
ModuleCheck 'sofia-sip'
if [ $? -eq 0 ]; then
	cd /usr/src/libs/sofia-sip && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./bootstrap.sh && ./configure --host=$ARCH --prefix=$OUT/sys; fi && make -j $(nproc --all) && make install
fi

ModuleCheck 'spandsp'
if [ $? -eq 0 ]; then
	cd /usr/src/libs/spandsp && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./bootstrap.sh && ./configure --host=$ARCH --prefix=$OUT/sys; fi && make -j $(nproc --all) && make install 
fi

ModuleCheck 'rts'
if [ $? -eq 0 ]; then
    cd /usr/src/rts/libs/libvpx && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then CC=$ARCH-gcc CXX=$ARCH-g++ AR=$ARCH-ar LD=$ARCH-g++ AS=$ARCH-as STRIP=$ARCH-strip NM=$ARCH-nm ./configure --enable-pic --disable-docs --disable-examples --disable-install-bins --disable-install-srcs --disable-unit-tests --target=armv7-linux-gcc;fi
	cd /usr/src/rts && if [[ ! -f Makefile || "$2" == '--force-build' ]]; then ./bootstrap.sh && ./configure --host=$ARCH --prefix=$FREESWITCH_PREFIX --disable-signalwire; fi && make  && make install
fi