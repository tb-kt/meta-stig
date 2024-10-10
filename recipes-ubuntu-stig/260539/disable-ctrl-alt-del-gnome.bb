SUMMARY = "Disable Ctrl-Alt-Delete Key Sequence for Graphical User Interface"
DESCRIPTION = "A recipe to disable the x86 Ctrl-Alt-Delete key sequence for graphical user interface sessions on Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check, set, and configure script source URI
SRC_URI = "file://disable_ctrl_alt_del_gnome.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/disable_ctrl_alt_del_gnome.sh ${D}${bindir}/disable_ctrl_alt_del_gnome
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/disable_ctrl_alt_del_gnome"
