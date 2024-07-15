#!/bin/bash

set -e -x -o pipefail

wget -N https://gitlab.com/fscarmen/warp/-/raw/main/menu.sh 
bash menu.sh [option] [lisence/url/token]

mkdir -p uploads
cp *.txt ./uploads/