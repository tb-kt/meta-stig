SUMMARY = "Configure DOD PKI Certificate Authorities for Ubuntu 22.04 LTS"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to use DOD PKI-established certificate authorities for verification of secure sessions."
LICENSE = "CLOSED"

SRC_URI = "file://configure_dod_pki.sh \
           file://DOD_PKE_CA_chain.pem"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_dod_pki.sh ${D}${sysconfdir}/security/configure_dod_pki.sh
    install -d ${D}${sysconfdir}/share/ca-certificates
    install -m 0644 ${WORKDIR}/DOD_PKE_CA_chain.pem ${D}${sysconfdir}/share/ca-certificates/DOD_PKE_CA_chain.pem
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_dod_pki.sh \
                ${sysconfdir}/share/ca-certificates/DOD_PKE_CA_chain.pem"
