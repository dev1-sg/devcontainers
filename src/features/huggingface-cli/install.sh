#!/usr/bin/env bash

set -exo pipefail

function main() {
    if ! command -v uv >/dev/null 2>&1; then
    echo "uv not found, installing..."

    export PYTHON_VERSION=3.13.5
    export UV_INSTALL_DIR=/usr/local/bin
    export UV_PYTHON_INSTALL_DIR=/opt/uv
    export UV_PYTHON_BIN_DIR=/usr/local/bin
    export UV_TOOL_DIR=/opt/uv/tool
    export UV_TOOL_BIN_DIR=/usr/local/bin

    mkdir -p /opt/uv /opt/uv/tool

    curl -fsSL https://astral.sh/uv/install.sh | bash \
        && uv python install "${PYTHON_VERSION}" --default
    else
    echo "uv found, installing tool..."

    export UV_TOOL_DIR=/opt/uv/tool
    export UV_TOOL_BIN_DIR=/usr/local/bin

    mkdir -p /opt/uv /opt/uv/tool

    uv tool install huggingface_hub
    fi
}

main
