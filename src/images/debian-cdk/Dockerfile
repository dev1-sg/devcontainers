# syntax=docker.io/docker/dockerfile:1

FROM public.ecr.aws/dev1-sg/base/node:24.5.0-bookworm AS node
FROM public.ecr.aws/dev1-sg/base/python:3.13.5-bookworm AS python
FROM public.ecr.aws/dev1-sg/base/debian:bookworm AS base

ARG USER=vscode
ARG USER_ID=1000
ARG PRIMARY_GROUP_ID=1000
ARG PYTHON_VERSION
ARG NODE_VERSION

COPY --from=node /opt /opt
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=python /opt /opt
COPY --from=python /usr/local/lib /usr/local/lib
COPY --from=python /usr/local/bin /usr/local/bin

USER root

RUN apt-get update \
    && if [ -d "/home/debian" ]; then userdel -f debian; fi \
    && groupadd --gid "${PRIMARY_GROUP_ID}" "${USER}" \
    && useradd --system --uid "${USER_ID}" --gid "${PRIMARY_GROUP_ID}" -m "${USER}" \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${USER}" \
    && chmod 0440 "/etc/sudoers.d/${USER}" \
    && passwd -d "${USER}" \
    && git config --system --add safe.directory '*'

FROM base AS build

ARG CDKTF_VERSION=0.21.0
ARG AWSCDK_VERSION=2.1026.0

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    unzip tar gzip make build-essential

RUN npm i -g cdktf-cli@${CDKTF_VERSION} aws-cdk@${AWSCDK_VERSION}

RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-$(case $(uname -m) in x86_64) echo x86_64 ;; aarch64) echo aarch64 ;; esac).zip" -o /tmp/awscliv2.zip \
    && unzip -qq /tmp/awscliv2.zip -d /tmp \
    && bash /tmp/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli

FROM base AS final

COPY --from=build /usr/local/aws-cli /usr/local/aws-cli
COPY --from=build /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=build /usr/local/bin /usr/local/bin

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER "${USER}"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV TZ=Asia/Singapore \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    HOME="/home/${USER}" \
    PYTHON_VERSION="${PYTHON_VERSION}" \
    NODE_VERSION="${NODE_VERSION}"

WORKDIR "${HOME}"
