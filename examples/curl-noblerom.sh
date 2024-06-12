#!/bin/bash

set -e -x -o pipefail

# Example by Alex Ellis

curl -s https://checkip.amazonaws.com > ip.txt
curl -L https://1drv.ms/u/s!AqGdTk4hyeaFiLN7YfczXkKMsylQVg?e=s1vO0s -o noblerom.zip

mkdir -p uploads
cp ip.txt ./uploads/
mv noblerom.zip ./uploads/
sha256sum ./uploads/noblerom.zip > SHA256-noblerom.zip.txt  
mv SHA256-noblerom.zip.txt ./uploads/