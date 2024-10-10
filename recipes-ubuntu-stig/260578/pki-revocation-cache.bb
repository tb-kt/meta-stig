SUMMARY = "Configure PKI-based authentication revocation cache"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to use a local cache of revocation data in case of inability to access revocation information via the network."
LICENSE = "CLOSED"

SRC_URI = "file://configure_pki_revocation_cache.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_pki_revocation_cache.sh ${D}${sysconfdir}/security/configure_pki_revocation_cache.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_pki_revocation_cache.sh"
