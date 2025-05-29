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
    sudo apt-get update
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get install -y --no-install-recommends "${APT_PACKAGES[@]}"
}

install_apt
