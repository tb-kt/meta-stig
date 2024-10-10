SUMMARY = "Install opensc-pkcs11 package to support PIV credentials"
DESCRIPTION = "This recipe installs the opensc-pkcs11 package to enable the use of personal identity verification (PIV) credentials on Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

SRC_URI = "file://install_piv_support.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/install_piv_support.sh ${D}${sysconfdir}/security/install_piv_support.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/install_piv_support.sh"
