FROM openjdk:8

LABEL Maintainer="ekansh@opscale.io"

ARG KAFKA_VERSION=2.4.0
ARG SCALA_VERSION=2.12

ENV MAIN_PKGS="\
        wget ca-certificates zip net-tools supervisor " \
    DEV_PKGS="\
        nano vim telnet tar netcat"

RUN apt-get update && \
    apt-get install -y ${MAIN_PKGS} && \
    apt-get install -y ${DEV_PKGS}

WORKDIR /kafka

ENV PACKAGE_NAME=kafka_${SCALA_VERSION}-${KAFKA_VERSION}

RUN wget http://apachemirror.wuchna.com/kafka/${KAFKA_VERSION}/${PACKAGE_NAME}.tgz -O ${PACKAGE_NAME}.tgz && \
    tar -xvzf ${PACKAGE_NAME}.tgz && \
    rm ${PACKAGE_NAME}.tgz && \
    mv ${PACKAGE_NAME}/* . && \
    rm -r ${PACKAGE_NAME} && \
    ls

#************ NOTES for Running this Container ****************
# 1 - Disable Ram Swap. This can be done by assigning memory and memory-swap flags a same value