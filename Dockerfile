FROM alpine:3.8

RUN mkdir /opt; cd /opt; \
    wget https://download.java.net/java/early_access/alpine/27/binaries/openjdk-11+27_linux-x64-musl_bin.tar.gz \
    && tar zxf openjdk-11+27_linux-x64-musl_bin.tar.gz \
    && ln -s jdk-11 java \
    && rm -f openjdk-11+27_linux-x64-musl_bin.tar.gz

ENV JAVA_HOME=/opt/java
ENV PATH="$PATH:$JAVA_HOME/bin"


