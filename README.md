# lspack
Free package manager by Lombardi & Streicher 

## How to install? (linux)

* Open terminal
* Paste following command:

```bash
curl -s https://raw.githubusercontent.com/lspack/lspack/main/lspack_install_script.sh | sudo sh
```

Uninstall:
```bash
sudo rm -rf /usr/bin/lspack
```

## How to use?

* Open terminal

Install:
```bash
sudo lspack install <package> [-a, --author <author>]
```

Update:
```bash
sudo lspack update <package>
```

Upgrade lspack:
```bash
sudo lspack upgrade
```

Uninstall package:
```bash
sudo lspack remove <package>
```

