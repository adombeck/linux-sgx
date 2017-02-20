#!/bin/bash

set -e

exec 5>&1

echo "Building..."
# make DEBUG=1

echo "Trying to uninstall SDK"
sudo /opt/intel/sgxsdk/uninstall.sh || true

echo "Installing SDK..."
output=$(make sdk_install_pkg | tee /dev/fd/5)
re='Generated sdk installer: ([^'$'\n'']*)'
[[ "$output" =~ $re ]] && installer="${BASH_REMATCH[1]}"

sudo $installer <<'EOF'
no
/opt/intel
EOF

echo "Trying to uninstall SDK"
sudo /opt/intel/sgxpsw/uninstall.sh || true

echo "Installing PSW..."
output=$(make psw_install_pkg | tee /dev/fd/5)
re='Generated psw installer: ([^'$'\n'']*)'
[[ "$output" =~ $re ]] && installer="${BASH_REMATCH[1]}"

sudo $installer

