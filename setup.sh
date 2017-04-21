#!/bin/bash

set -e

exec 5>&1

echo "Checking if running in correct OS..."
([[ `lsb_release -a 2> /dev/null` == *"14.04"* ]] || [[ `lsb_release -a 2> /dev/null` == *"16.04"* ]]) || (echo "Wrong OS. Run on Ubuntu 14.04 or Ubuntu 16.04."; exit 1)

PACKAGES_TO_INSTALL=""
for PACKAGE in build-essential ocaml automake autoconf libtool wget python libcurl4-openssl-dev protobuf-compiler protobuf-c-compiler libprotobuf-dev libprotobuf-c-dev
do
  dpkg -s $PACKAGE > /dev/null || PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $PACKAGE"
done
[[ -z $PACKAGES_TO_INSTALL ]] || sudo apt install $PACKAGES_TO_INSTALL

[[ -d external/ippcp_internal/inc ]] || ./download_prebuilt.sh

echo "Cleaning..."
make clean

echo "Building SDK..."
make -j8 -C sdk/ USE_OPT_LIBS=1 DEBUG=1

echo "Building PSW..."
make -j8 -C psw/ USE_OPT_LIBS=1 DEBUG=1

./install_sdk.sh

./install_psw.sh
