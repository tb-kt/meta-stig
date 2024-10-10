SUMMARY = "Configure multifactor authentication for remote access using libpam-pkcs11"
DESCRIPTION = "This recipe installs the libpam-pkcs11 package on Ubuntu 22.04 LTS to configure multifactor authentication for remote access to privileged accounts."
LICENSE = "CLOSED"

SRC_URI = "file://configure_mfa.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/configure_mfa.sh ${D}${sysconfdir}/security/configure_mfa.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/configure_mfa.sh"
