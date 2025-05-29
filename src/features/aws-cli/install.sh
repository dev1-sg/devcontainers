#!/usr/bin/env bash

set -exo pipefail

ARCH="$(uname -m)"
AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:-""}"
AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:-""}"
AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-""}"
DEVCONTAINER_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEVCONTAINER_USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
DEVCONTAINER_HOME="/home/${USERNAME}"

case ${ARCH} in
    x86_64) ARCH="x86_64";;
    aarch64 | armv8*) ARCH="aarch64";;
    *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
esac

APT_PACKAGES=(
    ca-certificates
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
    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip" -o ./awscliv2.zip
    cat "${FEATURE_DIR}/files/public-key" > ./public-key
    gpg --import ./public-key
    curl -fsSL https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip.sig -o ./awscliv2.sig
    gpg --verify ./awscliv2.sig ./awscliv2.zip
    unzip ./awscliv2.zip
    sudo ./aws/install
    rm -rf ./awscliv2.zip ./awscliv2.sig ./public-key ./aws
    mkdir -p "${HOME}/.aws"
}

main
