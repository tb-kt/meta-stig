SUMMARY = "Custom Repository Setup"
LICENSE = "CLOSED"

SRC_URI = "file://setup-repos.sh"

inherit allarch

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/setup-repos.sh ${D}${bindir}
}

pkg_postinst_ontarget:${PN}() {
    ${bindir}/setup-repos.sh
}

RDEPENDS:${PN} += "bash"