SUMMARY = "Enable Graphical User Interface Session Lock for User Reauthentication"
DESCRIPTION = "A recipe to ensure that the graphical user interface session lock is enabled on Ubuntu 22.04 LTS, and remains in place until the user reauthenticates."
LICENSE = "CLOSED"

# No specific dependencies
DEPENDS = ""

# This recipe doesn't produce any packages
ALLOW_EMPTY:${PN} = "1"

# Define the check, set, and configure GUI session lock script source URI
SRC_URI = "file://check_set_session_lock.sh"

# No source directory is needed
S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/check_set_session_lock.sh ${D}${bindir}/check_set_session_lock
}

# This recipe doesn't compile anything
do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${bindir}/check_set_session_lock"
