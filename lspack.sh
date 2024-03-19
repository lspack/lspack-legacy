#!/bin/bash

# Default base URL for safe installations
DEFAULT_BASE_URL="https://github.com/lspack"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NOCOLOR='\033[0m'

download_package() {
	local package_name="$1"
	local url="$2"

	echo -e "Downloading ${YELLOW}$package_name${NOCOLOR}..."
	cd /tmp/ || exit 1

	git clone --quiet "$url" >/dev/null || {
		echo -e "${RED}Error: Failed to download ${YELLOW}$package_name${RED}.${NOCOLOR}"
		rm -rf /tmp/$package_name || exit 1
		exit 1
	}

	echo -e "${YELLOW}$package_name ${GREEN}downloaded successfully!${NOCOLOR}"
}

compile_package() {
	local package_name="$1"

	echo -e "Compiling ${YELLOW}$package_name${NOCOLOR}..."

	if [ -e "$package_name/lspack_install_script.sh" ]; then
		local curcd="$(pwd)"
		chmod +x "$package_name/lspack_install_script.sh"
		cd "$package_name" || exit 1
		./lspack_install_script.sh || {
			echo -e "${RED}Error: Failed to execute installation script${NOCOLOR}"
			exit 1
		}
		cd "$curcd" || exit 1
	elif [ -e "$package_name/main.c" ]; then
		sudo gcc -o "/usr/local/bin/$package_name" "$package_name/main.c" || {
			echo -e "${RED}Error: Compilation failed${NOCOLOR}"
			exit 1
		}
	elif [ -e "$package_name/$package_name.c" ]; then
		sudo gcc -o "/usr/local/bin/$package_name" "$package_name/$package_name.c" || {
			echo -e "${RED}Error: Compilation failed${NOCOLOR}"
			exit 1
		}
	else
		echo -e "${RED}Failed${NOCOLOR}"
		exit 1
	fi

	sudo rm -rf "/tmp/$package_name"
	echo -e "${YELLOW}$package_name ${GREEN}compiled successfully!${NOCOLOR}"
}

install_package() {
	local package_name="$1"
	local base_url="$2"

	download_package "$package_name" "$base_url/$package_name"
	compile_package "$package_name"
}

remove_package() {
	local package_name="$1"
	if [ "$package_name" = "" ]; then
		echo -e "${RED}Error: Please enter package name${NOCOLOR}"
		exit 1
	fi
	sudo rm -rf "/usr/local/bin/$1" || {
		echo -e "${RED}Error: Couldn't remove ${YELLOW}package_name${NOCOLOR}"
		exit 1
	}

	echo -e "${GREEN} $package_name removed successfully!${NOCOLOR}"
}

update_package() {
	local package_name="$1"
	if [ "$package_name" = "lspack" ]; then
		echo -e "Deprecated. Use '${YELLOW}lspack upgrade${NOCOLOR}'."
		exit 1
	fi
	remove_package "$package_name"
	install_package "$package_name"
}

main() {
	if [ "$#" -eq 0 ]; then
		echo -e "Usage: lspack <install | remove | update> <package> [option]"
		echo -e ""
		echo -e "Options: (${RED}UNSAFE${NOCOLOR})"
		echo -e "-a, --author <author> .............. Installs package from untrusted author"
		exit
	fi

	local action="$1"
	local package_name="$2"
	local base_url="$DEFAULT_BASE_URL"

	case "$action" in
	"install")
		if [ "$3" = "-a" ] || [ "$3" = "--author" ]; then
			if [ -z "$4" ]; then
				echo -e "${RED}Error: Author name not provided.${NOCOLOR}"
				exit 1
			fi
			base_url="https://github.com/$4"
		fi
		install_package "$package_name" "$base_url"
		;;
	"remove")
		remove_package "$package_name"
		;;
	"update")
		remove_package "$package_name"
		install_package "$package_name" "$base_url"
		;;
	"upgrade")
		remove_package "lspack"
		install_package "lspack" "https://github.com/lspack"
		;;
	*)
		echo -e "${RED}Invalid action${NOCOLOR}"
		exit 1
		;;
	esac
}

main "$@"
