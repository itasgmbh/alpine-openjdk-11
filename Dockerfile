FROM alpine:3.8

ENV EA_BUILD=28

RUN mkdir /opt; cd /opt; \
    wget https://download.java.net/java/early_access/alpine/${EA_BUILD}/binaries/openjdk-11+${EA_BUILD}_linux-x64-musl_bin.tar.gz \
    && tar zxf openjdk-11+${EA_BUILD}_linux-x64-musl_bin.tar.gz \
    && ln -s jdk-11 java \
    && rm -f openjdk-11+${EA_BUILD}_linux-x64-musl_bin.tar.gz \
    && rm -f /opt/jdk-11/lib/src.zip
    

ENV JAVA_HOME=/opt/java
ENV PATH="$PATH:$JAVA_HOME/bin"
