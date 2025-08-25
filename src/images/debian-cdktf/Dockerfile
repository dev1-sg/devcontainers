# syntax=docker.io/docker/dockerfile:1

FROM public.ecr.aws/dev1-sg/base/node:24.5.0-bookworm AS node
FROM public.ecr.aws/dev1-sg/base/python:3.13.5-bookworm AS python
FROM public.ecr.aws/dev1-sg/base/golang:1.24.6-bookworm AS golang
FROM public.ecr.aws/dev1-sg/base/debian:bookworm AS base

ARG PYTHON_VERSION
ARG NODE_VERSION
ARG GO_VERSION

COPY --from=node /opt /opt
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=python /opt /opt
COPY --from=python /usr/local/lib /usr/local/lib
COPY --from=python /usr/local/bin /usr/local/bin
COPY --from=golang /usr/local/go /usr/local/go

USER root

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    zsh gettext

FROM base AS build-base

ARG TERRAFORM_VERSION=1.13.0
ARG TERRAGRUNT_VERSION=0.86.0
ARG TERRAFORM_DOCS_VERSION=0.20.0

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    unzip tar gzip

RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-$(case $(uname -m) in x86_64) echo x86_64 ;; aarch64) echo aarch64 ;; esac).zip" -o /tmp/awscliv2.zip \
    && unzip -qq /tmp/awscliv2.zip -d /tmp \
    && bash /tmp/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli

RUN curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_$(case $(uname -m) in x86_64) echo amd64 ;; aarch64) echo arm64 ;; esac).zip" -o /tmp/terraform.zip \
    && unzip -qq /tmp/terraform.zip -d /tmp \
    && cp /tmp/terraform /usr/local/bin/terraform \
    && chmod +x /usr/local/bin/terraform

RUN curl -fsSL "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_$(case $(uname -m) in x86_64) echo amd64 ;; aarch64) echo arm64 ;; esac)" -o /tmp/terragrunt \
    && cp /tmp/terragrunt /usr/local/bin/terragrunt \
    && chmod +x /usr/local/bin/terragrunt

RUN curl -fsSL "https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-$(case $(uname -m) in x86_64) echo amd64 ;; aarch64) echo arm64 ;; esac).tar.gz" -o /tmp/terraform-docs.tar.gz \
    && tar -xvf /tmp/terraform-docs.tar.gz -C /tmp \
    && cp /tmp/terraform-docs /usr/local/bin/terraform-docs \
    && chmod +x /usr/local/bin/terraform-docs

FROM node AS build-node

ARG AWSCDK_VERSION=2.1026.0
ARG CDKTF_VERSION=0.21.0
ARG CDK8S_VERSION=2.201.5

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    make build-essential

RUN npm i -g aws-cdk@${AWSCDK_VERSION} cdktf-cli@${CDKTF_VERSION} cdk8s-cli@${CDK8S_VERSION}

FROM base AS final

COPY --from=build-base /usr/local/aws-cli /usr/local/aws-cli
COPY --from=build-base /usr/local/bin /usr/local/bin
COPY --from=build-node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=build-node /usr/local/bin /usr/local/bin

ENV PYTHON_VERSION="${PYTHON_VERSION}" \
    NODE_VERSION="${NODE_VERSION}" \
    GO_VERSION="${GO_VERSION}" \
    GO_PATH=/go \
    GOTOOLCHAIN=local

ENV PATH="/go/bin:/usr/local/go/bin:${PATH}"

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root
