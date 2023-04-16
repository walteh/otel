#!/usr/bin/env bash

ENTRY=$1
OS=$2
ARCH=$3

export AWS_DEFAULT_REGION="us-east-1"

export arn="arn:aws:lambda:us-east-1:901920570463:layer:aws-otel-collector-$ARCH-ver-0-72-0:1"

export url="$(aws lambda get-layer-version-by-arn --arn "$arn" --query 'Content.Location' --output text --region 'us-east-1')"

curl "$url" --output layer.zip

mkdir -p "./build/${OS}-${ARCH}"

unzip -FF layer.zip -d "./build/${OS}-${ARCH}"
