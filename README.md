# lspack-legacy
Free package manager by Lombardi & Streicher

## Important notice
**NO LONGER IN SUPPORT!**
Use modern version of *lspack* (currently in development).
This version is no longer supported in any way.

## How to install? (linux)

* Open terminal
* Paste following command:

```bash
curl -s https://raw.githubusercontent.com/lspack/lspack-legacy/master/lspack_install_script.sh | sudo sh
```

Uninstall:
```bash
sudo rm -rf /usr/bin/leglspack
```

## How to use?

* Open terminal

Install:
```bash
sudo leglspack install <package> [-a, --author <author>]
```

Update:
```bash
sudo leglspack update <package>
```

Upgrade lspack:
```bash
sudo leglspack upgrade
```

Uninstall package:
```bash
sudo leglspack remove <package>
```

