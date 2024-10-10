SUMMARY = "Enforce password change of at least eight characters"
DESCRIPTION = "This recipe enforces password complexity on Ubuntu 22.04 LTS by ensuring that passwords must change at least eight characters during an update."
LICENSE = "CLOSED"

SRC_URI = "file://enforce_password_difok.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/security
    install -m 0755 ${WORKDIR}/enforce_password_difok.sh ${D}${sysconfdir}/security/enforce_password_difok.sh
}

do_compile[noexec] = "1"

FILES:${PN} += "${sysconfdir}/security/enforce_password_difok.sh"
