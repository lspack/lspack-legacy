#!/bin/bash

sudo rm -rf /usr/local/bin/leglspack>>/dev/null
sudo curl -so /usr/local/bin/leglspack https://raw.githubusercontent.com/lspack/lspack-legacy/master/lspack.sh
sudo chmod +x /usr/local/bin/leglspack
