#!/bin/bash

set -e -x -o pipefail

# Example by Alex Ellis

curl -s https://checkip.amazonaws.com > ip.txt
curl -L https://channels.nixos.org/nixos-24.05/latest-nixos-minimal-aarch64-linux.iso

mkdir -p uploads
cp ip.txt ./uploads/
cp latest-nixos-minimal-aarch64-linux.iso ./uploads/
