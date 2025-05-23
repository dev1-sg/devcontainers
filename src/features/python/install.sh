#!/usr/bin/env bash

set -exo pipefail

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
    sudo apt-get update
}

function install_python() {
    export DEBIAN_FRONTEND=noninteractive
    sudo apt install -y --no-install-recommends python3.12 python3-pip
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
