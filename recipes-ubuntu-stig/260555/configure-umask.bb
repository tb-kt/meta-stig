SUMMARY = "Configure UMASK to restrict default permissions to user's own files"
DESCRIPTION = "This recipe configures the system to define default filesystem permissions so that authenticated users can only read and modify their own files by setting UMASK to 077"
LICENSE = "CLOSED"

SRC_URI = "file://configure_umask.sh"

# No specific dependencies
DEPENDS = ""

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/configure_umask.sh ${D}${sysconfdir}/configure_umask.sh
}

do_compile[noexec] = "1"

# Add the script to the main package
FILES:${PN} += "${sysconfdir}/configure_umask.sh"
