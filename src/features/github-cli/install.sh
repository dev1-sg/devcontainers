#!/usr/bin/env bash

set -exo pipefail

ARCH="$(uname -m)"
DEVCONTAINER_USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
DEVCONTAINER_HOME="/home/${USERNAME}"
GH_TOKEN="${GH_TOKEN:-""}"

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
    curl -fsSL "https://github.com/cli/cli/releases/download/v2.72.0/gh_2.72.0_linux_${ARCH}.tar.gz" -o "./gh_2.72.0_linux_${ARCH}.tar.gz" \
    && tar -xvf "gh_2.72.0_linux_${ARCH}.tar.gz" --strip-components=2 -C /usr/local/bin \
    && rm -rf gh_2.72.0_linux_${ARCH}.tar.gz
}

main
