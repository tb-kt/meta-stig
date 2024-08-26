DESCRIPTION = "Custom GRUB configuration to enable auditing"
LICENSE = "CLOSED"

SRC_URI += "file://grub.cfg"

do_install() {
    install -d ${D}${sysconfdir}/default
    install -m 0644 ${WORKDIR}/grub.cfg ${D}${sysconfdir}/default/grub
}

FILES_${PN} = "${sysconfdir}/default/grub"

