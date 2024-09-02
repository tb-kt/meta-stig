SUMMARY = "Sysctl configuration for kernel.dmesg_restrict"
LICENSE = "CLOSED"

SRC_URI = "file://sysctl.conf"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/sysctl.d/
    install -m 0644 ${WORKDIR}/sysctl.conf ${D}${sysconfdir}/sysctl.d/
}

FILES:${PN} += "${sysconfdir}/sysctl.d"

