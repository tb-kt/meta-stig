SUMMARY = "Disable Wireless Network Adapters"
DESCRIPTION = "A recipe to disable all wireless network adapters on Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the script source URI
SRC_URI = "file://disable_wireless_network_adapters.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/disable_wireless_network_adapters.sh ${D}${bindir}/disable_wireless_network_adapters
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/disable_wireless_network_adapters"
