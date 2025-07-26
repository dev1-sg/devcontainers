# syntax=docker.io/docker/dockerfile:1

FROM public.ecr.aws/dev1-sg/ubuntu/ubuntu:24.04 AS base

ARG PYTHON_VERSION=3.12
ARG USER=vscode
ARG USER_ID=1000
ARG PRIMARY_GROUP_ID=1000

ARG NVM_VERSION=0.40.3
ARG PYTHON_VERSION=3.13.5
ARG NODE_VERSION=24.4.1

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    sudo bash git curl ca-certificates jq locales-all \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN if [ -d "/home/ubuntu" ]; then userdel -f ubuntu; fi \
    && groupadd --gid "${PRIMARY_GROUP_ID}" "${USER}" \
    && useradd --system --uid "${USER_ID}" --gid "${PRIMARY_GROUP_ID}" -m "${USER}" \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${USER}" \
    && chmod 0440 "/etc/sudoers.d/${USER}" \
    && passwd -d "${USER}" \
    && git config --system --add safe.directory '*'

USER "${USER}"

ENV TZ=Asia/Singapore \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    HOME="/home/${USER}"

ENV PATH="${HOME}/.local/bin:${PATH}"

WORKDIR "${HOME}"

RUN curl -fsSL https://astral.sh/uv/install.sh | bash \
    && uv python install "${PYTHON_VERSION}" --default

RUN curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash \
    && \. "${HOME}/.nvm/nvm.sh"
