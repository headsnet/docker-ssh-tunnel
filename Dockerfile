FROM alpine:3.8

MAINTAINER Ben Roberts <ben@headsnet.com>

RUN apk add --update \
    openssh-client && \
    rm -rf /var/cache/apk/*

CMD rm -rf /root/.ssh && \
    mkdir /root/.ssh && \
    cp -R /root/ssh/* /root/.ssh/ && \
    chmod -R 600 /root/.ssh/* && \
    ssh \
    -p 2020 \
    -vv \
    -o StrictHostKeyChecking=no \
    -N \
    -L *:$LOCAL_PORT:127.0.0.1:$REMOTE_PORT \
    $REMOTE_USER@$REMOTE_HOST && \
    while true; do sleep 30; done;

EXPOSE 1-65535
