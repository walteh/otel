# syntax=docker/dockerfile:experimental

FROM golang:1:20 as builder

COPY ./build /build

RUN	cp /build/$(go env GOOS)-$(go env GOARCH) /opt

FROM scratch

COPY --from=builder /opt /opt

COPY ./images/lambda-go-collector/config.yaml /opt/collector-config/config.yaml


# https://github.com/open-telemetry/opentelemetry-lambda/blob/4650ef29508f97f007ec6c32178d1b079e746b99/collector/internal/collector/collector.go
