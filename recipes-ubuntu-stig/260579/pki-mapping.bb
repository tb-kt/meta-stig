SUMMARY = "Configure PKI-based authentication mapping for Ubuntu 22.04 LTS"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to map the authenticated identity to the user or group account for PKI-based authentication."
LICENSE = "CLOSED"

SRC_URI = "file://configure_pki_mapping.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_pki_mapping.sh ${D}${sysconfdir}/security/configure_pki_mapping.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_pki_mapping.sh"
