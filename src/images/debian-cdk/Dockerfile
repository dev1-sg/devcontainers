# syntax=docker.io/docker/dockerfile:1

FROM public.ecr.aws/dev1-sg/base/node:24.5.0-bookworm AS node
FROM public.ecr.aws/dev1-sg/base/python:3.13.5-bookworm AS python
FROM public.ecr.aws/dev1-sg/base/debian:bookworm AS base

ARG PYTHON_VERSION
ARG NODE_VERSION

COPY --from=node /opt /opt
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=python /opt /opt
COPY --from=python /usr/local/lib /usr/local/lib
COPY --from=python /usr/local/bin /usr/local/bin

USER root

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    zsh gettext

FROM base AS build-base

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    unzip

RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-$(case $(uname -m) in x86_64) echo x86_64 ;; aarch64) echo aarch64 ;; esac).zip" -o /tmp/awscliv2.zip \
    && unzip -qq /tmp/awscliv2.zip -d /tmp \
    && bash /tmp/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli

FROM node AS build-node

ARG AWSCDK_VERSION=2.1026.0

RUN npm i -g aws-cdk@${AWSCDK_VERSION}

FROM base AS final

COPY --from=build-base /usr/local/aws-cli /usr/local/aws-cli
COPY --from=build-base /usr/local/bin /usr/local/bin
COPY --from=build-node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=build-node /usr/local/bin /usr/local/bin

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PYTHON_VERSION="${PYTHON_VERSION}" \
    NODE_VERSION="${NODE_VERSION}"

WORKDIR /root
