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
| 1 | [ci/alpine](https://gallery.ecr.aws/dev1-sg/ci/alpine) | ci | public.ecr.aws/dev1-sg/ci/alpine | 3.21 | 48.24 MB |
| 2 | [ci/ansible](https://gallery.ecr.aws/dev1-sg/ci/ansible) | ci | public.ecr.aws/dev1-sg/ci/ansible | 3.13.4 | 224.06 MB |
| 3 | [ci/debian](https://gallery.ecr.aws/dev1-sg/ci/debian) | ci | public.ecr.aws/dev1-sg/ci/debian | bookworm | 116.03 MB |
| 4 | [ci/golang](https://gallery.ecr.aws/dev1-sg/ci/golang) | ci | public.ecr.aws/dev1-sg/ci/golang | 1.24.4 | 359.20 MB |
| 5 | [ci/kubectl](https://gallery.ecr.aws/dev1-sg/ci/kubectl) | ci | public.ecr.aws/dev1-sg/ci/kubectl | 1.32.0 | 97.86 MB |
| 6 | [ci/node](https://gallery.ecr.aws/dev1-sg/ci/node) | ci | public.ecr.aws/dev1-sg/ci/node | 24.1.0 | 460.12 MB |
| 7 | [ci/packer](https://gallery.ecr.aws/dev1-sg/ci/packer) | ci | public.ecr.aws/dev1-sg/ci/packer | 1.11.2 | 62.68 MB |
| 8 | [ci/python](https://gallery.ecr.aws/dev1-sg/ci/python) | ci | public.ecr.aws/dev1-sg/ci/python | 3.13.4 | 63.03 MB |
| 9 | [ci/terraform](https://gallery.ecr.aws/dev1-sg/ci/terraform) | ci | public.ecr.aws/dev1-sg/ci/terraform | 1.12.0 | 163.00 MB |
| 10 | [ci/ubuntu](https://gallery.ecr.aws/dev1-sg/ci/ubuntu) | ci | public.ecr.aws/dev1-sg/ci/ubuntu | noble | 94.55 MB |

---

last_updated: ('Mon Jun  9 02:10:16 2025', '+08')