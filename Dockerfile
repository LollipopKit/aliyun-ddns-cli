FROM golang:alpine as builder
ENV CGO_ENABLED=0 \
    GO111MODULE=on
RUN apk add --update git curl
ADD . $GOPATH/src/github.com/LollipopKit/aliyun-ddns-cli
RUN set -ex \
    && cd $GOPATH/src/github.com/LollipopKit/aliyun-ddns-cli \
    && go build -ldflags "-X main.version=$(curl -sSL https://api.github.com/repos/LollipopKit/aliyun-ddns-cli/commits/master | \
            sed -n '{/sha/p; /date/p;}' | sed 's/.* \"//g' | cut -c1-10 | tr '[:lower:]' '[:upper:]' | sed 'N;s/\n/@/g' | head -1)" . \
    && mv aliyun-ddns-cli $GOPATH/bin/


FROM chenhw2/alpine:base
LABEL MAINTAINER LollipopKit <https://github.com/LollipopKit>

# /usr/bin/aliyun-ddns-cli
COPY --from=builder /go/bin /usr/bin

ENV AKID=1234567890 \
    AKSCT=abcdefghijklmn \
    DOMAIN=ddns.example.win \
    IPAPI=[IPAPI-GROUP] \
    REDO=0

CMD aliyun-ddns-cli \
    --ipapi ${IPAPI} \
    auto-update \
    --domain ${DOMAIN} \
    --redo ${REDO}
