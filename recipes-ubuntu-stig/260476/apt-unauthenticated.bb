SUMMARY = "Configure APT to prevent the installation of unsigned software"
DESCRIPTION = "Ensures that APT is configured to prevent the installation of patches, service packs, device drivers, or Ubuntu operating system components without verification they have been digitally signed using an approved certificate."
LICENSE = "CLOSED"
PR = "r0"

SRC_URI = "file://disable-allowunauthenticated.sh"

inherit allarch

do_install() {
    install -d ${D}${sysconfdir}/apt/apt.conf.d
    install -m 0755 ${WORKDIR}/disable-allowunauthenticated.sh ${D}${sysconfdir}/apt/apt.conf.d/99-disable-allowunauthenticated.sh
}

FILES_${PN} += "${sysconfdir}/apt/apt.conf.d/99-disable-allowunauthenticated.sh"
