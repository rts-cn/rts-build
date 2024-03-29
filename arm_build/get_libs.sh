#!/bin/bash

# 1、openssl
if [ ! -f "/usr/src/libs/openssl-OpenSSL_1_1_1t.tar.gz" ];then
   wget -P /usr/src/libs/ https://codeload.github.com/openssl/openssl/tar.gz/refs/tags/OpenSSL_1_1_1t
   cd /usr/src/libs/ && tar zxvf openssl-OpenSSL_1_1_1t.tar.gz
fi

# 2、 tiff
if [ ! -f "/usr/src/libs/tiff-4.6.0rc2.tar.gz" ];then
    wget -P /usr/src/libs/ https://download.osgeo.org/libtiff/tiff-4.6.0rc2.tar.gz
    cd /usr/src/libs/ && tar zxvf tiff-4.6.0rc2.tar.gz
fi

# 3、libjpeg
if [ ! -f "/usr/src/libs/libjpeg-turbo-3.0.2.tar.gz" ];then
    wget -P /usr/src/libs/ https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/3.0.2/libjpeg-turbo-3.0.2.tar.gz
    cd /usr/src/libs/ && tar zxvf libjpeg-turbo-3.0.2.tar.gz
fi

# 6、zlib
if [ ! -f "/usr/src/libs/zlib.tar.gz" ];then
    wget -P /usr/src/libs/ https://www.zlib.net/current/zlib.tar.gz
    cd /usr/src/libs/ && tar zxvf zlib.tar.gz
fi

# 7、sqlite3
if [ ! -f "/usr/src/libs/sqlite-autoconf-3450200.tar.gz" ];then
    wget -P /usr/src/libs/ https://www.sqlite.org/2024/sqlite-autoconf-3450200.tar.gz
    cd /usr/src/libs/ && tar zxvf sqlite-autoconf-3450200.tar.gz
fi

# 8、curl
if [ ! -f "/usr/src/libs/curl-8.6.0.tar.gz" ];then
    wget -P /usr/src/libs/ https://curl.se/download/curl-8.6.0.tar.gz
    cd /usr/src/libs/ && tar zxvf curl-8.6.0.tar.gz
fi

#9、pcre
if [ ! -f "/usr/src/libs/pcre-8.45.tar.gz" ];then
    wget -P /usr/src/libs/ https://udomain.dl.sourceforge.net/project/pcre/pcre/8.45/pcre-8.45.tar.gz
    cd /usr/src/libs/ && tar zxvf pcre-8.45.tar.gz
fi

#10、speex
if [ ! -f "/usr/src/libs/speex-1.2.1.tar.gz" ];then
    wget -P /usr/src/libs/ http://downloads.xiph.org/releases/speex/speex-1.2.1.tar.gz
    cd /usr/src/libs/ && tar zxvf speex-1.2.1.tar.gz
fi

#11、speexdsp
if [ ! -f "/usr/src/libs/speexdsp-1.2.1.tar.gz" ];then
    wget -P /usr/src/libs/ http://downloads.xiph.org/releases/speex/speexdsp-1.2.1.tar.gz
    cd /usr/src/libs/ && tar zxvf speexdsp-1.2.1.tar.gz
fi

#12、 uuid
if [ ! -f "/usr/src/libs/libuuid-1.0.3.tar.gz" ];then
    wget -P /usr/src/libs/ https://udomain.dl.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz
    cd /usr/src/libs/ && tar zxvf libuuid-1.0.3.tar.gz
fi

#13、ncurses
if [ ! -f "/usr/src/libs/ncurses-6.4.tar.gz" ];then
    wget -P /usr/src/libs/ https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.4.tar.gz
    cd /usr/src/libs/ && tar zxvf ncurses-6.4.tar.gz
fi

#14、libedit
if [ ! -f "/usr/src/libs/libedit-20230828-3.1.tar.gz" ];then
    wget -P /usr/src/libs/ https://thrysoee.dk/editline/libedit-20230828-3.1.tar.gz
    cd /usr/src/libs/ && tar zxvf libedit-20230828-3.1.tar.gz
fi
