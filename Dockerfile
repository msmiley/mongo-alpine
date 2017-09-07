FROM alpine:3.6

RUN apk update && apk --no-cache add -U mongodb && mkdir -p /data/db

VOLUME ["/data/db"]

ENTRYPOINT ["mongod"]
