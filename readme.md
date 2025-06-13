# devcontainers

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

## Images


| # | Repository Name | Group | URI | Latest Tag | Size |
|---|-----------------|-------|-----|------------|------|
| 1 | [devcontainer/dev-base](https://gallery.ecr.aws/dev1-sg/devcontainer/dev-base) | devcontainer | public.ecr.aws/dev1-sg/devcontainer/dev-base | 1.0.0 | 267.61 MB |
| 2 | [devcontainer/ubuntu-base](https://gallery.ecr.aws/dev1-sg/devcontainer/ubuntu-base) | devcontainer | public.ecr.aws/dev1-sg/devcontainer/ubuntu-base | jammy | 113.04 MB |

---

last_updated: ('Fri Jun 13 16:32:18 2025', '+08')