FROM alpine:3 AS download
WORKDIR /
RUN apk update \
 && apk add curl \
 && curl -sL 'https://packages.cloudfoundry.org/stable?release=linux64-binary&version=7.4.0&source=github-rel' | tar -xzv \
 && chmod 0755 cf

FROM alpine:3
RUN apk update \
 && apk add curl jq
COPY --from=download /cf /usr/bin/cf
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
