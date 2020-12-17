FROM alpine:3.9

RUN apk update && apk --no-cache add -U mongodb mongodb-tools && mkdir -p /data/db

ENV HOST=mongo

RUN mongod --bind_ip_all --replSet rs0 --fork --syslog && \
    mongo --eval "rs.initiate({_id: 'rs0', members:[{_id: 0, host: '$HOST:27017'}]})" && \
    mongo admin --eval "db.adminCommand({shutdown: 1, force: true})"; exit 0

ENTRYPOINT ["mongod", "--bind_ip_all", "--replSet", "rs0"]
CMD []