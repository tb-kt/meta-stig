DESCRIPTION = "Ensure chrony package is installed to comply with STIG requirements"
LICENSE = "CLOSED"

inherit packagegroup

PACKAGE_ARCH = "${MACHINE_ARCH}"

PACKAGES = " \
    chrony-package \
"

RDEPENDS_${PN} = "chrony"

SRC_URI = ""

do_install() {
    # Ensure chrony is installed
    apt-get update
    apt-get install -y chrony
}

