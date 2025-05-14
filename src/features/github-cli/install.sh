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

function install_github_cli() {
    cd "${HOME}"
    curl -fsSL "https://github.com/cli/cli/releases/download/v2.72.0/gh_2.72.0_linux_${ARCH}.tar.gz" -o "./gh_2.72.0_linux_${ARCH}.tar.gz" \
    && tar -xvf "gh_2.72.0_linux_${ARCH}.tar.gz" --strip-components=2 -C /usr/local/bin \
    && rm -rf gh_2.72.0_linux_${ARCH}.tar.gz
}

function main() {
    ARCH="$(uname -m)"
    case ${ARCH} in
        x86_64) ARCH="amd64";;
        aarch64 | armv8*) ARCH="arm64";;
        *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
    esac
    install_deps
    install_github_cli
}

main
