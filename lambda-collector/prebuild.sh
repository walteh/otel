#!/bin/bash -e

OS=$(go env GOOS)
ARCH=$(go env GOARCH)
REGION="us-east-1"

export AWS_DEFAULT_REGION="${REGION}"

arn="arn:aws:lambda:${REGION}:901920570463:layer:aws-otel-collector-${ARCH}-ver-0-72-0:1"
url="$(aws lambda get-layer-version-by-arn --arn "$arn" --query 'Content.Location' --output text --region "${REGION}")"

mkdir -p "./build/${OS}-${ARCH}"

# Download the file to a temporary file
temp_file=$(mktemp)
curl -sL "${url}" -o "${temp_file}"

# Extract the downloaded file
unzip "${temp_file}" -d "./build/${OS}-${ARCH}"

# Remove the temporary file
rm "${temp_file}"
