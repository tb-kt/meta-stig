SUMMARY = "Enable Graphical User Interface Session Lock after 15 Minutes of Inactivity"
DESCRIPTION = "A recipe to ensure that the graphical user interface session is configured to lock after 15 minutes of inactivity on Ubuntu 22.04 LTS."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check, set, and configure GUI session lock script source URI
SRC_URI = "file://check_set_session_lock_15min.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_set_session_lock_15min.sh ${D}${bindir}/check_set_session_lock_15min
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_set_session_lock_15min"
