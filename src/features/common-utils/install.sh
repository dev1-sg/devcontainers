#!/usr/bin/env bash

set -exo pipefail

DEVCONTAINER_USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
DEVCONTAINER_HOME="/home/${USERNAME}"

APT_PACKAGES=(
    bash-completion
    build-essential
    ca-certificates
    curl
    file
    git
    gpg
    jq
    lsb-release
    lsof
    nano
    net-tools
    nano
    openssh-client
    screen
    strace
    sudo
    tree
    unzip
    wget
    xz-utils
    zip
    zsh
)

function install_apt() {
    $(which sudo) apt-get update
    DEBIAN_FRONTEND=noninteractive $(which sudo) apt-get install -y --no-install-recommends "${APT_PACKAGES[@]}"
}

install_apt
