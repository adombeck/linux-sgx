#!/bin/bash

set -e

exec 5>&1

echo "Trying to uninstall PSW..."
sudo /opt/intel/sgxpsw/uninstall.sh || true

echo "Installing PSW..."
output=$(./linux/installer/bin/build-installpkg.sh psw | tee /dev/fd/5)
re='Generated psw installer: ([^'$'\n'']*)'
[[ "$output" =~ $re ]] && installer="${BASH_REMATCH[1]}"

sudo $installer

