#!/usr/bin/env bash

set -exo pipefail

AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID:-""}"
AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY:-""}"
AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-""}"
DEVCONTAINER_USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
DEVCONTAINER_HOME="/home/${USERNAME}"

ARCH="$(uname -m)"

case "${ARCH}" in
    x86_64) ARCH="x86_64";;
    aarch64 | armv8*) ARCH="aarch64";;
    *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
esac

APT_PACKAGES=(
    sudo
    ca-certificates
    curl
    unzip
)

function clean_up() {
    sudo rm -rf /tmp/awscliv2.zip /tmp/awscliv2.sig /tmp/public-key /tmp/aws
}

trap clean_up EXIT

function install_apt() {
    $(which sudo) apt-get update
    DEBIAN_FRONTEND=noninteractive $(which sudo) apt-get install -y --no-install-recommends "${APT_PACKAGES[@]}"
}

function main() {
    install_apt
    sudo curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip" -o /tmp/awscliv2.zip
    sudo unzip /tmp/awscliv2.zip -d /tmp
    sudo bash /tmp/aws/install
    mkdir -p "${HOME}/.aws"
}

main
