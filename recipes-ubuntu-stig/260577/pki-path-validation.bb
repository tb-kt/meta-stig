SUMMARY = "Configure PKI-based authentication path validation"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to validate certificates by constructing a certification path to an accepted trust anchor."
LICENSE = "CLOSED"

SRC_URI = "file://configure_pki_path_validation.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_pki_path_validation.sh ${D}${sysconfdir}/security/configure_pki_path_validation.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_pki_path_validation.sh"
