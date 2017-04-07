#!/bin/bash

set -e

exec 5>&1

echo "Checking if running in correct OS..."
([[ `lsb_release -a 2> /dev/null` == *"14.04"* ]] || [[ `lsb_release -a 2> /dev/null` == *"16.04"* ]]) || (echo "Wrong OS. Run on Ubuntu 14.04 or Ubuntu 16.04."; exit 1)

PACKAGES_TO_INSTALL=""
for PACKAGE in build-essential ocaml automake autoconf libtool wget python libcurl4-openssl-dev protobuf-compiler protobuf-c-compiler libprotobuf-dev libprotobuf-c0-dev
do
  dpkg -s $PACKAGE > /dev/null || PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $PACKAGE"
done
[[ -z $PACKAGES_TO_INSTALL ]] || sudo apt install $PACKAGES_TO_INSTALL

[[ -d external/ippcp_internal/inc ]] || ./download_prebuilt.sh

echo "Cleaning..."
make clean

echo "Building SDK..."
make -C sdk/ USE_OPT_LIBS=1 DEBUG=1

echo "Building PSW..."
make -C psw/ USE_OPT_LIBS=1 DEBUG=1

echo "Trying to uninstall SDK..."
sudo /opt/intel/sgxsdk/uninstall.sh || true

echo "Installing SDK..."
output=$(./linux/installer/bin/build-installpkg.sh sdk | tee /dev/fd/5)
re='Generated sdk installer: ([^'$'\n'']*)'
[[ "$output" =~ $re ]] && installer="${BASH_REMATCH[1]}"

sudo $installer <<'EOF'
no
/opt/intel
EOF

echo "Trying to uninstall PSW..."
sudo /opt/intel/sgxpsw/uninstall.sh || true

echo "Installing PSW..."
output=$(./linux/installer/bin/build-installpkg.sh psw | tee /dev/fd/5)
re='Generated psw installer: ([^'$'\n'']*)'
[[ "$output" =~ $re ]] && installer="${BASH_REMATCH[1]}"

sudo $installer

