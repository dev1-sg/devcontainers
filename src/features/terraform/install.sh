#!/usr/bin/env bash

set -exo pipefail

DEVCONTAINER_USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
DEVCONTAINER_HOME="/home/${USERNAME}"

TERRAFORM_VERSION=1.9.6
TERRAGRUNT_VERSION=0.67.14
TERRAFORMDOCS_VERSION=0.19.0

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
    jq
    make
    unzip
    wget
    xz-utils
)

function clean_up() {
    sudo rm -rf "/tmp/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip" "/tmp/terragrunt_linux_${ARCH}" "/tmp/terraform-docs-v${TERRAFORMDOCS_VERSION}-linux-${ARCH/_/-}.tar.gz"
}

trap clean_up EXIT

function install_apt() {
    $(which sudo) apt-get update
    DEBIAN_FRONTEND=noninteractive $(which sudo) apt-get install -y --no-install-recommends "${APT_PACKAGES[@]}"
}

function install_terraform() {
    cd /tmp
    wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip"
    unzip "/tmp/terraform_${TERRAFORM_VERSION}_linux_${ARCH}.zip" -d /tmp
    sudo mv /tmp/terraform /usr/local/bin/terraform
    sudo chmod +x /usr/local/bin/terraform
}

function install_terragrunt() {
    cd /tmp
    wget "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_${ARCH}"
    sudo mv "/tmp/terragrunt_linux_${ARCH}" /usr/local/bin/terragrunt
    sudo chmod +x /usr/local/bin/terragrunt
}

function install_terraform_docs() {
    cd /tmp
    wget "https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORMDOCS_VERSION}/terraform-docs-v${TERRAFORMDOCS_VERSION}-linux-${ARCH/_/-}.tar.gz"
    tar -xvf "terraform-docs-v${TERRAFORMDOCS_VERSION}-linux-${ARCH/_/-}.tar.gz"
    sudo mv /tmp/terraform-docs /usr/local/bin/terraform-docs
    sudo chmod +x /usr/local/bin/terraform-docs
}

function main() {
    install_apt
    install_terraform
    install_terragrunt
    install_terraform_docs
}

main
