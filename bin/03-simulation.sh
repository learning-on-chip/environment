#!/bin/bash

set -e

function join() {
    local delimiter="${1}"
    shift
    echo -n "${1}"
    shift
    printf "%s" "${@/#/${delimiter}}"
}

SIMULATION_ROOT="${HOME}/simulation"
PIN_VERSION='2.14-71313-gcc.4.4.7-linux'
PIN_URL="http://software.intel.com/sites/landingpage/pintool/downloads/pin-${PIN_VERSION}.tar.gz"
SNIPER_URL='http://snipersim.org/download/b8df51129affee69/git/sniper.git'
SNIPER_VERSION='dbeda5af99d444fe2198dab4c5efa60dd0275b16'
BENCHMARKS_URL='http://snipersim.org/git/benchmarks.git'
BENCHMARKS_EXCLUDE='cpu2006 npb splash2'

echo "export PIN_HOME=${SIMULATION_ROOT}/pin" >> ~/.bash_profile
echo "export SNIPER_ROOT=${SIMULATION_ROOT}/sniper" >> ~/.bash_profile
echo "export BENCHMARKS_ROOT=${SIMULATION_ROOT}/benchmarks" >> ~/.bash_profile
echo 'export NO_PYTHON_DOWNLOAD=1' >> .bash_profile

source ~/.bash_profile

mkdir -p "${SIMULATION_ROOT}"

cd "${SIMULATION_ROOT}"
curl -LO "${PIN_URL}"
tar -xzf "pin-${PIN_VERSION}.tar.gz"
ln -s "pin-${PIN_VERSION}" pin

git clone "${SNIPER_URL}" "${SIMULATION_ROOT}/sniper"
cd "${SIMULATION_ROOT}/sniper"
git reset --hard "${SNIPER_VERSION}"
sed -i.bak 's/ia32 intel64/intel64/' tools/makepythondist.sh
sed -i.bak 's/curl http/curl -L http/' tools/makepythondist.sh
sed -i.bak 's/ --without-signal-module//' tools/makepythondist.sh
sed -i.bak '/Delete all .py for which a .pyc exists/d' tools/makepythondist.sh
tools/makepythondist.sh
tar -xzf sniper-python27-intel64.tgz
mv python_kit intel64
mkdir python_kit
mv intel64 python_kit/
make

git clone "${BENCHMARKS_URL}" "${SIMULATION_ROOT}/benchmarks"
cd "${SIMULATION_ROOT}/benchmarks"
sed -i.bak "/\\($(join '\|' ${BENCHMARKS_EXCLUDE})\\)/d" Makefile
make -C parsec parsec-2.1/.parsec_source
sed -i.bak 's/all install_docs install_sw/all install_sw/' parsec/parsec-2.1/pkgs/libs/ssl/src/Makefile.org
make
