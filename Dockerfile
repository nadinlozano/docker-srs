FROM debian:buster

RUN apt-get update && \
    apt-get install -y --force-yes --no-install-recommends libpcre3 zlib1g git python sudo ffmpeg \
      automake autoconf libtool build-essential wget ca-certificates unzip libpcre3-dev zlib1g-dev && \
    mkdir -p /data/install && \
    cd /data/install && \
    git clone https://github.com/ossrs/srs && cd srs/trunk && \
    ./configure && make -j4 && \
    apt-get remove -y --purge --auto-remove automake autoconf libtool build-essential wget ca-certificates unzip libpcre3-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*
    
RUN echo 'daemon off;' >> /data/install/srs/trunk/conf/srs.conf

WORKDIR /data/install/srs/trunk
CMD ["./objs/srs", "-c", "conf/http.flv.live.conf"]
