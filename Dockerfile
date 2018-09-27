FROM alpine:3.8

ENV JDK_BUILD=28
ENV JDK_ARCHIVE="openjdk-11+${JDK_BUILD}_linux-x64-musl_bin.tar.gz"
ENV JAVA_HOME=/opt/java

RUN mkdir /opt; cd /opt; \
    wget https://download.java.net/java/early_access/alpine/${JDK_BUILD}/binaries/${JDK_ARCHIVE} \
    && wget https://download.java.net/java/early_access/alpine/${JDK_BUILD}/binaries/${JDK_ARCHIVE}.sha256 \
    && echo "  ${JDK_ARCHIVE}" >> ${JDK_ARCHIVE}.sha256 \
    && sha256sum -c ${JDK_ARCHIVE}.sha256 \
    && tar zxf ${JDK_ARCHIVE} \    
    && rm ${JDK_ARCHIVE} ${JDK_ARCHIVE}.sha256 \
    && rm -f rm ${JAVA_HOME}/lib/src.zip \
    && ln -s jdk-11 java
    
ENV PATH="$PATH:$JAVA_HOME/bin"
ENV JAVA_VERSION 11-ea+${JDK_BUILD}
ENV JAVA_ALPINE_VERSION 11~${JDK_BUILD}-1
