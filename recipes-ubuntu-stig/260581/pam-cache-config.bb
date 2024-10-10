SUMMARY = "Configure PAM to prohibit the use of cached authentications after one day"
DESCRIPTION = "This recipe configures Ubuntu 22.04 LTS to prohibit the use of cached PAM authentications after one day."
LICENSE = "CLOSED"

SRC_URI = "file://configure_pam_cache.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_pam_cache.sh ${D}${sysconfdir}/security/configure_pam_cache.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_pam_cache.sh"
