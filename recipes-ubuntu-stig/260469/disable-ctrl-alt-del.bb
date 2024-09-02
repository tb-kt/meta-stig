SUMMARY = "Disable Ctrl-Alt-Delete key sequence"
DESCRIPTION = "This recipe disables the Ctrl-Alt-Delete key sequence to prevent accidental reboots."
LICENSE = "CLOSED"
PR = "r0"

SRC_URI = "file://disable-ctrl-alt-del.sh"

do_install() {
    install -d ${D}${sysconfdir}/systemd/system/
    ln -sf /dev/null ${D}${sysconfdir}/systemd/system/ctrl-alt-del.target
}

FILES_${PN} = "${sysconfdir}/systemd/system/ctrl-alt-del.target"

