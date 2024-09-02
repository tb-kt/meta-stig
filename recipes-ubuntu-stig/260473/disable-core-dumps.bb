DESCRIPTION = "Disable kernel core dumps using sysctl"
SECTION = "security"
LICENSE = "MIT"

SRC_URI = ""

do_install() {
    # Disable core dumps via sysctl configuration
    install -d ${D}${sysconfdir}/sysctl.d
    echo "kernel.core_pattern=|/bin/false" > ${D}${sysconfdir}/sysctl.d/99-disable-core-dumps.conf
    echo "fs.suid_dumpable=0" >> ${D}${sysconfdir}/sysctl.d/99-disable-core-dumps.conf
}

