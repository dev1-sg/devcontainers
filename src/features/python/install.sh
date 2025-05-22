#!/usr/bin/env bash

set -exo pipefail

VERSION=${VERSION:-"3.13.3"}

function install_deps() {
    install \
        sudo \
        wget \
        ca-certificates \
        xz-utils
}

function install() {
    $(which sudo) apt-get update
    export DEBIAN_FRONTEND=noninteractive
    $(which sudo) apt-get install -y --no-install-recommends "$@"
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt-get update
}

function install_python() {
    export DEBIAN_FRONTEND=noninteractive
    sudo apt install -y --no-install-recommends python3.13
    pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir poetry
}

function main() {
    install_deps
    install_python
    sudo apt-get clean
    sudo rm -rf /var/lib/apt/lists/*
}

main
