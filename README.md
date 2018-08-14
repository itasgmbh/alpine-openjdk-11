# alpine-openjdk-11
This is image that installed binary file of openjdk 11 on alpine  linux.

The image using this docker file is public to https://hub.docker.com/r/hirokimatsumoto/alpine-openjdk-11

Please refer to the following for the background that I needed.
https://qiita.com/h-r-k-matsumoto/items/1725fc587ce127671560

# Result

The size of 1 GB has been reduced to about 85 MB.
Image size is the result output by the `docker images` command.

| image type |jlink|size |
|:-----------|:------------|-----:|
|openjdk:11-jdk|not used| 1GB |
|openjdk:11-jdk|used   | 468MB |
|hirokimatsumoto/alpine-openjdk-11|not used | 336MB |
|hirokimatsumoto/alpine-openjdk-11| used   | 84.6MB |


# Background problem
The docker image of openjdk 11 is published in the official respoitory of docker hub.
https://hub.docker.com/_/openjdk/

This image has the following problem.

- `openjdk:11-jdk` tag image size is large. There is about 1 GB.
- Even if you use jlink, image size is 400 MB.
- Java Flight Recorder does not work in `jre` tag images.

The file size was confirmed with the following command.

```
$ sudo docker images |grep jdk
docker.io/openjdk                            11-jdk   f684efd78557  2 weeks ago         979 MB
$
```
I confirmed that libjvm.so becomes larger when using jlink.

```
$ docker run -it --rm openjdk:11-jdk /bin/sh
# ls -l /usr/lib/jvm/java-11-openjdk-amd64/lib/server/
total 34944
-rw-r--r-- 1 root root     1322 Jul 27 03:41 Xusage.txt
-r--r--r-- 1 root root 18210816 Jul 27 22:22 classes.jsa
-rw-r--r-- 1 root root    14440 Jul 27 03:41 libjsig.so
-rw-r--r-- 1 root root 17551048 Jul 27 03:41 libjvm.so
# jlink \
     --module-path /opt/java/jmods \
     --compress=2 \
     --add-modules java.base,java.logging,jdk.jfr  \
     --no-header-files \
     --no-man-pages \
     --output /opt/jdk-11-mini-runtime
#  ls -l /opt/jdk-11-mini-runtime/lib/server/
total 414452
-rw-r--r-- 1 root root      1322 Aug 14 09:41 Xusage.txt
-rw-r--r-- 1 root root     25384 Aug 14 09:41 libjsig.so
-rw-r--r-- 1 root root 424362808 Aug 14 09:41 libjvm.so
#
```

The generated libjvm.so increased to 424 MB.
This problem is probably part of the following issue issue.
https://github.com/docker-library/openjdk/issues/217

