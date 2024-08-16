FROM golang:1.22.4-alpine AS builder

RUN apk update && apk add --no-cache git

WORKDIR /cfst
RUN https://github.com/XIU2/CloudflareSpeedTest.git . && git checkout v2.2.5
