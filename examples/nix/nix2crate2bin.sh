#!/bin/bash

set -e -x -o pipefail

url --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-config

nix run github:nix-community/nix-init -- --y

mkdir -p uploads
cp *.txt ./uploads/
