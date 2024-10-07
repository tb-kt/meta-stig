SUMMARY = "Remove systemd-timesyncd"
DESCRIPTION = "A recipe to check for and thoroughly remove systemd-timesyncd from the system"
LICENSE = "CLOSED"


# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the removal script source URI
SRC_URI = "file://remove_timesyncd.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/remove_timesyncd.sh ${D}${bindir}/remove_timesyncd
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/remove_timesyncd"

