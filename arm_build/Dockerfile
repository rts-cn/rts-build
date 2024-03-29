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
