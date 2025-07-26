#!/usr/bin/env bash

set -exo pipefail

DEVCONTAINER_USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
DEVCONTAINER_HOME="/home/${USERNAME}"
GITLAB_TOKEN="${GITLAB_TOKEN:-""}"

ARCH="$(uname -m)"

case "${ARCH}" in
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

function clean_up() {
    sudo rm -rf "/tmp/glab_1.57.0_linux_${ARCH}.tar.gz"
}

trap clean_up EXIT

function install_apt() {
    $(which sudo) apt-get update
    DEBIAN_FRONTEND=noninteractive $(which sudo) apt-get install -y --no-install-recommends "${APT_PACKAGES[@]}"
}

function main() {
    install_apt
    cd "${HOME}"
    curl -fsSL "https://gitlab.com/gitlab-org/cli/-/releases/v1.57.0/downloads/glab_1.57.0_linux_${ARCH}.tar.gz" -o "/tmp/glab_1.57.0_linux_${ARCH}.tar.gz"
    tar -xvf "/tmp/glab_1.57.0_linux_${ARCH}.tar.gz" --strip-components=1 -C /usr/local/bin
}

main
