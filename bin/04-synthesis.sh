#!/bin/bash

set -e

CODE_ROOT="${HOME}/code"
RUSTUP_URL='https://static.rust-lang.org/rustup.sh'
STUDIO_URL="https://github.com/learning-on-chip/studio.git"
STUDIO_ROOT="${CODE_ROOT}/github.com/learning-on-chip/studio"

echo "export STUDIO_ROOT='${STUDIO_ROOT}'" >> ~/.bash_profile

curl -sSf "${RUSTUP_URL}" | sudo sh

git clone "${STUDIO_URL}" "${STUDIO_ROOT}" --recursive
make -C "${STUDIO_ROOT}" install
