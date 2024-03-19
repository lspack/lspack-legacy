#!/bin/bash

sudo rm -rf /usr/local/bin/leglspack>>/dev/null
sudo curl -so /usr/local/bin/lspack https://raw.githubusercontent.com/lspack/lspack_legacy/main/lspack.sh
sudo chmod +x /usr/local/bin/leglspack
