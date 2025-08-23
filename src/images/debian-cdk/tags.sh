#!/usr/bin/env bash

set -e

debian=$(sed -n 's|.*debian:\([a-zA-Z]*\).*|\1|p' Dockerfile | head -1)
python=$(sed -n 's|.*python:\([0-9]\+\.[0-9]\+\.[0-9]\+\).*|\1|p' Dockerfile | head -1)
node=$(sed -n 's|.*node:\([0-9]\+\.[0-9]\+\.[0-9]\+\).*|\1|p' Dockerfile | head -1)

if [ -z "$debian" ] || [ -z "$python" ] || [ -z "$node" ]; then exit 1; fi

export AWS_ECR_PUBLIC_IMAGE_TAG="${debian}"
export AWS_ECR_PUBLIC_IMAGE_TAG_DEBIAN="${debian}"
export AWS_ECR_PUBLIC_IMAGE_TAG_PYTHON="${python}"
export AWS_ECR_PUBLIC_IMAGE_TAG_NODE="${node}"

if [ -n "$GITHUB_ENV" ]; then
  echo "AWS_ECR_PUBLIC_IMAGE_TAG=${AWS_ECR_PUBLIC_IMAGE_TAG}" >> $GITHUB_ENV
  echo "AWS_ECR_PUBLIC_IMAGE_TAG_DEBIAN=$AWS_ECR_PUBLIC_IMAGE_TAG_DEBIAN" >> $GITHUB_ENV
  echo "AWS_ECR_PUBLIC_IMAGE_TAG_PYTHON=$AWS_ECR_PUBLIC_IMAGE_TAG_PYTHON" >> $GITHUB_ENV
  echo "AWS_ECR_PUBLIC_IMAGE_TAG_NODE=$AWS_ECR_PUBLIC_IMAGE_TAG_NODE" >> $GITHUB_ENV
else
  echo "AWS_ECR_PUBLIC_IMAGE_TAG=${AWS_ECR_PUBLIC_IMAGE_TAG}"
  echo "AWS_ECR_PUBLIC_IMAGE_TAG_DEBIAN=$AWS_ECR_PUBLIC_IMAGE_TAG_DEBIAN"
  echo "AWS_ECR_PUBLIC_IMAGE_TAG_PYTHON=$AWS_ECR_PUBLIC_IMAGE_TAG_PYTHON"
  echo "AWS_ECR_PUBLIC_IMAGE_TAG_NODE=$AWS_ECR_PUBLIC_IMAGE_TAG_NODE"
fi
