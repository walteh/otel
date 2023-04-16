#!/usr/bin/env bash

ENTRY=$1
OS=$2
ARCH=$3

export AWS_DEFAULT_REGION="us-east-1"
export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"
export AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN}"

export arn="arn:aws:lambda:us-east-1:901920570463:layer:aws-otel-collector-$ARCH-ver-0-72-0:1"

export url="$(aws lambda get-layer-version-by-arn --arn "$arn" --query 'Content.Location' --output text --region 'us-east-1')"

curl "$url" --output layer.zip

unzip layer.zip -d "./build/${OS}-${ARCH}"
