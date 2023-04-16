#!/bin/bash -e

# Check for the required number of arguments
if [ $# -ne 3 ]; then
    echo "Usage: $0 <ENTRY> <OS> <ARCH>"
    exit 1
fi

ENTRY=$1
OS=$2
ARCH=$3
REGION="us-east-1"

# Set AWS region
export AWS_DEFAULT_REGION="${REGION}"

# Get the AWS Lambda layer ARN
arn="arn:aws:lambda:${REGION}:901920570463:layer:aws-otel-collector-${ARCH}-ver-0-72-0:1"

# Get the URL to download the Lambda layer
url="$(aws lambda get-layer-version-by-arn --arn "$arn" --query 'Content.Location' --output text --region "${REGION}")"

# Create the target directory
mkdir -p "./build/${OS}-${ARCH}"

# Download and extract the Lambda layer in one command
curl -sL "${url}" | unzip - -d "./build/${OS}-${ARCH}"
