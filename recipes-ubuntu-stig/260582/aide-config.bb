SUMMARY = "Install and configure AIDE for file integrity verification"
DESCRIPTION = "This recipe installs AIDE (Advanced Intrusion Detection Environment) on Ubuntu 22.04 LTS to verify the correct operation of all security functions."
LICENSE = "CLOSED"

SRC_URI = "file://install_aide.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/install_aide.sh ${D}${sysconfdir}/security/install_aide.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/install_aide.sh"
