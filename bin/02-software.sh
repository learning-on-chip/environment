#!/bin/bash

set -e

SOFTWARE_ROOT="${HOME}/software"
GIT_URL='https://github.com/git/git.git'
VIM_URL='https://github.com/vim/vim.git'
REDIS_VERSION='3.2.4'
REDIS_URL="http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz"
DOTDEVELOP_URL='https://github.com/IvanUkhov/.develop.git'
DOTVIM_URL='https://github.com/IvanUkhov/.vim.git'

mkdir -p "${SOFTWARE_ROOT}"

git clone "${GIT_URL}" "${SOFTWARE_ROOT}/git"
cd "${SOFTWARE_ROOT}/git"
make prefix=/usr/local
sudo make prefix=/usr/local install

git clone "${VIM_URL}" "${SOFTWARE_ROOT}/vim"
cd "${SOFTWARE_ROOT}/vim"
./configure --prefix=/usr/local install
sudo make install

cd "${SOFTWARE_ROOT}"
curl -LO "${REDIS_URL}"
tar -xzf "redis-${REDIS_VERSION}.tar.gz"
cd "redis-${REDIS_VERSION}"
make
sudo make PREFIX=/usr/local install

git clone "${DOTDEVELOP_URL}" ~/.develop
make -C ~/.develop

git clone "${DOTVIM_URL}" ~/.vim --recursive
make -C ~/.vim
