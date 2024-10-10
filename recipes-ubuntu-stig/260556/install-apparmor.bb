SUMMARY = "Install AppArmor to ensure it is present on the system"
DESCRIPTION = "This recipe ensures that the AppArmor package is installed on the system to comply with STIG requirements for program control."
LICENSE = "CLOSED"

SRC_URI = "file://install_apparmor.sh"

DEPENDS = ""

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/install_apparmor.sh ${D}${sysconfdir}/install_apparmor.sh
}

do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${sysconfdir}/install_apparmor.sh"
