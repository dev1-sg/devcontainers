# syntax=docker.io/docker/dockerfile:1

FROM public.ecr.aws/dev1-sg/base/node:24.2.0 AS node
FROM public.ecr.aws/dev1-sg/base/python:3.13.5 AS python
FROM public.ecr.aws/dev1-sg/base/golang:1.24.4 AS golang
FROM public.ecr.aws/dev1-sg/base/ubuntu:24.04 AS base

ARG USER=vscode
ARG USER_ID=1000
ARG PRIMARY_GROUP_ID=1000
ARG HOME=/home/$USER

ENV HOME=/home/$USER \
    SHELL=/bin/bash \
    PNPM_HOME="/opt/pnpm" \
    GOPATH="/go" \
    GOTOOLCHAIN="local"

ENV PATH="${PNPM_HOME}:${GOPATH}/bin:/usr/local/go/bin:${PATH}"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
    sudo git curl ca-certificates \
    && if [ -d "/home/ubuntu" ]; then userdel -f ubuntu; fi \
    && groupadd --gid $PRIMARY_GROUP_ID $USER \
    && useradd --system --uid $USER_ID --gid $PRIMARY_GROUP_ID -m $USER \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER \
    && passwd -d $USER \
    && git config --system --add safe.directory '*' \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=python /usr/local/bin /usr/local/bin
COPY --from=python /usr/local/lib /usr/local/lib
COPY --from=golang /usr/local/go /usr/local/go

RUN corepack enable \
    && corepack prepare pnpm --activate \
    && corepack prepare yarn --activate
