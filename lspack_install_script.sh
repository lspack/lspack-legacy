#!/bin/bash

sudo rm -rf /usr/local/bin/lspack>>/dev/null
sudo curl -so /usr/local/bin/lspack https://raw.githubusercontent.com/lspack/lspack/main/lspack.sh
sudo chmod +x /usr/local/bin/lspack
