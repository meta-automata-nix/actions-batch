#!/bin/bash

set -e -x -o pipefail

# Example by Alex Ellis

curl -s https://checkip.amazonaws.com > ip.txt
curl -L https://ollama.ai | sh 

mkdir -p uploads
cp ip.txt ./uploads/