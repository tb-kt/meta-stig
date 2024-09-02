# apt-configure_1.0.bb
DESCRIPTION = "Configure APT to remove unused packages after upgrades"
LICENSE = "MIT"
PR = "r0"

do_install() {
    # Ensure the target directory exists
    install -d ${D}/etc/apt/apt.conf.d

    # Add or modify the required settings in the 50-unattended-upgrades file
    cat << EOF > ${D}/etc/apt/apt.conf.d/50-unattended-upgrades
Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
EOF
}

FILES_${PN} += "/etc/apt/apt.conf.d/50-unattended-upgrades"

pkg_postinst_${PN}() {
    # Reload or restart necessary services to apply the changes, if applicable
    if [ -x /usr/bin/systemctl ]; then
        systemctl restart unattended-upgrades || true
    fi
}
