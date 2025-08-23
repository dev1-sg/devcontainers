# devcontainers

[![Build On Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new/?repo=github)

This repository provides a customized [.devcontainer](https://code.visualstudio.com/docs/devcontainers/containers) setup, designed for use with [vscode](https://code.visualstudio.com/) and GitHub Codespaces.

The repository is configured to automatically update and rebuild Docker images using Dependabot. Dependabot monitors each Dockerfile and creates pull requests to update them when new versions are available.

## Overview

This repository is a rework from the original [devcontainers](https://github.com/devcontainers) project, and it utilizes:

- [**devcontainer templates**](https://github.com/devcontainers/templates): devcontainer templates
- [**devcontainer features**](https://github.com/devcontainers/features): collection of devcontainer features
- [**devcontainer images**](https://github.com/devcontainers/images): pre-built devcontainer images

The **`src`** folder contains customizations and configurations that layer on top of these resources.

readme Docs are updated daily. Please check the regsitry gallery for the latest updates.

[https://gallery.ecr.aws/dev1-sg/](https://gallery.ecr.aws/dev1-sg/)

Features will no longer be added.

Ongoing work will focus on maintaining and improving Docker images and tags for faster startup times and reproducibility.
