#!/bin/bash

set -e

CODE_ROOT="${HOME}/code/github.com/learning-on-chip"
RUSTUP_URL='https://static.rust-lang.org/rustup.sh'

curl -sSf ${RUSTUP_URL} | sudo sh

mkdir -p ${CODE_ROOT}

git clone https://github.com/learning-on-chip/studio.git ${CODE_ROOT}/studio
make -C ${CODE_ROOT}/studio install
