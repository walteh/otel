# syntax=docker/dockerfile:experimental

FROM alpine:latest as builder

RUN apk add aws-cli curl unzip

RUN mkdir -p /opt

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_SESSION_TOKEN

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}

RUN export AWS_DEFAULT_REGION="us-east-1" && \
	export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" && \
	export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" && \
	export AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN}" && \
	export arn="arn:aws:lambda:us-east-1:901920570463:layer:aws-otel-collector-arm64-ver-0-72-0:1" && \
	export url="$(aws lambda get-layer-version-by-arn --arn "$arn" --query 'Content.Location' --output text --region 'us-east-1')" && \
	curl "$url" --output layer.zip

RUN unzip layer.zip -d /opt
RUN rm layer.zip

FROM alpine:latest

COPY --from=builder /opt /opt

COPY ./config.yaml /opt/collector-config/config.yaml


# https://github.com/open-telemetry/opentelemetry-lambda/blob/4650ef29508f97f007ec6c32178d1b079e746b99/collector/internal/collector/collector.go
