#!/usr/bin/env bash

set -exo pipefail

ARCH="$(uname -m)"
DEVCONTAINER_USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
DEVCONTAINER_HOME="/home/${USERNAME}"
NODE_VERSION=${VERSION:-"22.15.1"}

case ${ARCH} in
    x86_64) ARCH="linux-x64";;
    aarch64 | armv8*) ARCH="linux-arm64";;
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
    wget -q "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${ARCH}.tar.xz" -P "/tmp"
    tar -xvf "/tmp/node-v${NODE_VERSION}-${ARCH}.tar.xz" -C "/tmp"
    mv /tmp/node-v${NODE_VERSION}-${ARCH}/bin/* /usr/local/bin
    mv /tmp/node-v${NODE_VERSION}-${ARCH}/lib/* /usr/local/lib
    rm -rf "/tmp/node-v${NODE_VERSION}-${ARCH}" "/tmp/node-v${NODE_VERSION}-${ARCH}.tar.xz"
    npm install -g pnpm typescript
}

main
