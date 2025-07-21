#!/usr/bin/env bash

ubuntu=($(sed -n 's/^FROM .*:\([^ -]*\).*/\1/p' Dockerfile | head -1))
python=($(sed -n 's/^ARG PYTHON_VERSION=\(.*\)/\1/p' Dockerfile | head -1))

echo "${python:-dev}-${ubuntu:-null}"
