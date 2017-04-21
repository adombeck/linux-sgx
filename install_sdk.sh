#!/bin/bash

set -e

exec 5>&1

echo "Trying to uninstall SDK..."
sudo /opt/intel/sgxsdk/uninstall.sh || true
sudo /opt/python-sgx/sgxsdk/uninstall.sh || true

echo "Installing SDK..."
output=$(./linux/installer/bin/build-installpkg.sh sdk | tee /dev/fd/5)
re='Generated sdk installer: ([^'$'\n'']*)'
[[ "$output" =~ $re ]] && installer="${BASH_REMATCH[1]}"

sudo $installer <<'EOF'
no
/opt/python-sgx
EOF

