#!/usr/bin/env bash

set -exo pipefail

readonly USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
readonly HOME="/home/${USERNAME}"
readonly FEATURE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

readonly GH_TOKEN="${GH_TOKEN:-""}"

function install_deps() {
    install \
        sudo \
        wget \
        software-properties-common \
        ca-certificates \
        gpg \
        gpg-agent \
        unzip \
        xz-utils
}

function install() {
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends "$@"
    sudo apt-get clean
    sudo rm -rf /var/lib/apt/lists/*
}

function install_gitlab_cli() {
    cd "${HOME}"
    curl -fsSL "https://gitlab.com/gitlab-org/cli/-/releases/v1.57.0/downloads/glab_1.57.0_linux_${ARCH}.tar.gz" -o "./glab_1.57.0_linux_${ARCH}.tar.gz" \
    && tar -xvf "glab_1.57.0_linux_${ARCH}.tar.gz" --strip-components=1 -C /usr/local/bin \
    && rm -rf glab_1.57.0_linux_${ARCH}.tar.gz
}

function main() {
    ARCH="$(uname -m)"
    case ${ARCH} in
        x86_64) ARCH="amd64";;
        aarch64 | armv8*) ARCH="arm64";;
        *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
    esac
    install_deps
    install_gitlab_cli
}

main
