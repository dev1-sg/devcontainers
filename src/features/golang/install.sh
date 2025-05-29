#!/usr/bin/env bash

set -exo pipefail

ARCH="$(uname -m)"
DEVCONTAINER_USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
DEVCONTAINER_HOME="/home/${USERNAME}"
GO_VERSION=${VERSION:-"1.22.10"}

case ${ARCH} in
    x86_64) ARCH="amd64";;
    aarch64 | armv8*) ARCH="arm64";;
    *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
esac

APT_PACKAGES=(
    ca-certificates
    curl
    gpg
    gpg-agent
    software-properties-common
    unzip
    wget
    xz-utils
)

function install_apt() {
    sudo apt-get update
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get install -y --no-install-recommends "${APT_PACKAGES[@]}"
}

function main() {
    install_apt
    cd "${HOME}"
    wget -q "https://go.dev/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz" -P "/tmp"
    tar -xvf "/tmp/go${GO_VERSION}.linux-${ARCH}.tar.gz" -C "/tmp"
    sudo mv /tmp/go /usr/local
    rm -rf "/tmp/go${GO_VERSION}.linux-${ARCH}.tar.gz"
}

main
