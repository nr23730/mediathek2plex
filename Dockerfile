FROM alpine:3.17.3

RUN apk add --no-cache bash curl grep coreutils xmlstarlet
COPY ./pull.sh /pull.sh
ENTRYPOINT [ "/pull.sh" ]