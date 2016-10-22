#!/bin/bash

set -e

GCC_VERSION='4.8'
PACKAGES=(
    bison
    build-essential
    flex
    g++-${GCC_VERSION}-multilib
    gettext
    gfortran-${GCC_VERSION}
    git-core
    lib32z1-dev
    libboost-dev
    libbz2-dev
    libc6-dev-i386
    libcurl4-openssl-dev
    libncurses5-dev
    libsqlite3-dev
    libx11-dev
    libxext-dev
    libxi-dev
    libxmu-dev
    libxt-dev
    m4
    pkg-config
    python2.7-dev
    sqlite3
    xsltproc
)

sudo apt-get update
sudo apt-get install -y ${PACKAGES[@]}

sudo ln -s /usr/bin/gfortran-${GCC_VERSION} /usr/bin/f95
sudo ln -s /usr/bin/gfortran-${GCC_VERSION} /usr/bin/gfortran
