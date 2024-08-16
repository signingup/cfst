FROM golang:1.22.4-alpine AS builder

RUN apk update && apk add --no-cache git

WORKDIR /cfst
RUN git clone https://github.com/XIU2/CloudflareSpeedTest.git . && git checkout v2.2.5

#build cfst
RUN go mod download
RUN go build -o /go/bin/cloudflarespeedtest

FROM alpine:latest

RUN apk add --no-cache git tzdata dcron openrc bash nano curl ca-certificates net-tools bind-tools

COPY --from=builder /go/bin/. /usr/local/bin/
COPY --from=builder /cfst/ip*.txt /usr/local/bin/

COPY ./entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENV TZ=UTC
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["/usr/bin/entrypoint.sh"]
