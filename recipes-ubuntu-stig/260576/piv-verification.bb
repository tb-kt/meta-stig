SUMMARY = "Configure electronic verification of PIV credentials"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to verify PIV credentials via OCSP for personal identity verification."
LICENSE = "CLOSED"

SRC_URI = "file://configure_piv_verification.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_piv_verification.sh ${D}${sysconfdir}/security/configure_piv_verification.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_piv_verification.sh"
