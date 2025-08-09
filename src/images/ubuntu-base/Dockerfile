# syntax=docker.io/docker/dockerfile:1

FROM public.ecr.aws/dev1-sg/ubuntu/ubuntu:24.04 AS base

ARG USER=vscode
ARG USER_ID=1000
ARG PRIMARY_GROUP_ID=1000

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    sudo git curl ca-certificates locales \
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

WORKDIR "${HOME}"
