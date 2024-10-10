#!/bin/bash

set -e

setup_debian_repos() {
    cat <<EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian bullseye main
deb http://security.debian.org/debian-security bullseye-security main
deb http://deb.debian.org/debian bullseye-updates main
EOF

    cat <<EOF > /etc/apt/apt.conf.d/99no-check-valid-until
Acquire::Check-Valid-Until "false";
EOF

    wget -qO- https://ftp-master.debian.org/keys/archive-key-11.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/debian-archive-bullseye-stable.gpg

    apt-get update
}

setup_fedora_repos() {
    cat <<EOF > /etc/yum.repos.d/fedora.repo
[fedora]
name=Fedora \$releasever - \$basearch
baseurl=http://download.fedoraproject.org/pub/fedora/linux/releases/\$releasever/Everything/\$basearch/os/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$releasever-\$basearch
EOF

    dnf install -y fedora-gpg-keys
    dnf update -y
}

if command -v apt-get &> /dev/null; then
    echo "Debian-based system detected. Setting up APT repositories..."
    setup_debian_repos
elif command -v dnf &> /dev/null; then
    echo "RPM-based system detected. Setting up DNF repositories..."
    setup_fedora_repos
else
    echo "Unsupported package manager. Exiting."
    exit 1
fi

echo "Repository setup complete."