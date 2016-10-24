#!/bin/bash

set -e

CODE_ROOT="${HOME}/code/github.com/learning-on-chip"
RUSTUP_URL='https://static.rust-lang.org/rustup.sh'
STUDIO_URL='https://github.com/learning-on-chip/studio.git'

curl -sSf "${RUSTUP_URL}" | sudo sh

mkdir -p "${CODE_ROOT}"

git clone "${STUDIO_URL}" "${CODE_ROOT}/studio" --recursive
make -C "${CODE_ROOT}/studio" install
