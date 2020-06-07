FROM ubuntu:18.04

# install deps
RUN apt-get update
RUN apt-get install -y \
        zlib1g \
        zlib1g-dev \
        libpcre3 \
        libpcre3-dev \
        build-essential \
        openssl \
        libssl-dev \
        git

# pull nginx and rtmp fork
RUN mkdir /build
RUN cd /build && git clone --single-branch --branch master --depth=1 https://github.com/nginx/nginx.git
#RUN cd /build && git clone --single-branch --branch dev --depth=1 https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git
RUN cd /build && git clone --single-branch --branch master --depth=1 https://github.com/arut/nginx-rtmp-module.git

# build and install
RUN cd /build/nginx && ./auto/configure --add-module=../nginx-rtmp-module 
RUN cd /build/nginx && make -j $(getconf _NPROCESSORS_ONLN) && make install
RUN rm -rf /build

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
