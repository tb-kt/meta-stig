SUMMARY = "Ensure AppArmor is installed, enabled, and configured properly"
DESCRIPTION = "This recipe ensures AppArmor is installed and active, and profiles are enforced on Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

SRC_URI = "file://configure_apparmor.sh"

DEPENDS = ""

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/configure_apparmor.sh ${D}${sysconfdir}/configure_apparmor.sh
}

do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${sysconfdir}/configure_apparmor.sh"
