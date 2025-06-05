# common functions for install scripts

sudo () {
	echo "sudo $@"
	/usr/bin/sudo $@
}

ensure_installed() {
	for pkg in $@; do
		if ! dpkg-query -W -f'${Status}' "$pkg" | grep -q "install ok installed" &> /dev/null; then
			echo "$pkg: Installing..."
			sudo apt install "$pkg"
		else
			echo "$pkg: Already Installed"
		fi
	done
}

ensure_installed_nir() {
	for pkg in $@; do
		if ! dpkg-query -W -f'${Status}' "$pkg" | grep -q "install ok installed" &> /dev/null; then
			echo "$pkg: Installing..."
			sudo apt install --no-install-recommends -y "$pkg"
		else
			echo "$pkg: Already Installed"
		fi
	done
}
