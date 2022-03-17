FROM alpine:3.15.1

RUN apk add --no-cache bash curl grep coreutils xmlstarlet
COPY ./pull.sh /pull.sh
ENTRYPOINT [ "/pull.sh" ]