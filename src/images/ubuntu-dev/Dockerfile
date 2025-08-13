# syntax=docker.io/docker/dockerfile:1

FROM public.ecr.aws/dev1-sg/ubuntu/ubuntu:24.04 AS base

ARG USER=vscode
ARG USER_ID=1000
ARG PRIMARY_GROUP_ID=1000

USER root

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    sudo git curl ca-certificates locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8

RUN if [ -d "/home/ubuntu" ]; then userdel -f ubuntu; fi \
    && groupadd --gid "${PRIMARY_GROUP_ID}" "${USER}" \
    && useradd --system --uid "${USER_ID}" --gid "${PRIMARY_GROUP_ID}" -m "${USER}" \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${USER}" \
    && chmod 0440 "/etc/sudoers.d/${USER}" \
    && passwd -d "${USER}" \
    && git config --system --add safe.directory '*'

FROM base AS build

ARG NODE_VERSION=24.5.0

RUN ARCH="$(case $(uname -m) in x86_64) echo x64 ;; aarch64) echo arm64 ;; esac)" \
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    tar xz-utils \
    && curl -fsSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${ARCH}.tar.xz" -o /tmp/node.tar.xz \
    && tar --strip-components=1 -xvf /tmp/node.tar.xz -C /usr/local/ --wildcards '*/bin/*' '*/lib/*' '*/include/*' '*/share/*'

FROM base AS final

ARG PYTHON_VERSION=3.13.5

COPY --from=build /usr/local /usr/local

USER "${USER}"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV TZ=Asia/Singapore \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    HOME="/home/${USER}"

ENV PATH="${HOME}/.local/bin:${PATH}"

WORKDIR "${HOME}"

RUN curl -fsSL https://astral.sh/uv/install.sh | bash \
    && uv python install "${PYTHON_VERSION}" --default
