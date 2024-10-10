SUMMARY = "FIPS Mode Enablement for Ubuntu 22.04 LTS"
DESCRIPTION = "This recipe enables FIPS mode on Ubuntu 22.04 LTS, requiring Ubuntu Pro subscription to obtain FIPS Kernel cryptographic modules and enable FIPS."
LICENSE = "CLOSED"

SRC_URI = "file://configure_fips_mode.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/configure_fips_mode.sh ${D}${bindir}/configure_fips_mode.sh
}

FILES_${PN} += "${bindir}/configure_fips_mode.sh"

RDEPENDS_${PN} += "coreutils grub2"

pkg_postinst_${PN} () {
    #!/bin/sh
    if [ -n "$D" ]; then
        exit 1
    fi

    # Run the script to configure FIPS mode
    /bin/sh ${bindir}/configure_fips_mode.sh || {
        echo "Failed to enable FIPS mode"
        exit 1
    }
}
