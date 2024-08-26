SUMMARY = "Address space layout randomization configuration"
LICENSE = "CLOSED"

SRC_URI = "file://aslr.conf"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/sysctl.d/
    install -m 0644 ${WORKDIR}/aslr.conf ${D}${sysconfdir}/sysctl.d/
}

FILES:${PN} += "${sysconfdir}/sysctl.d"

