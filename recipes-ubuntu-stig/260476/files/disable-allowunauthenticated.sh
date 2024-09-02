#!/bin/sh

# This script configures APT to prevent the installation of unsigned software

APT_CONF_DIR="/etc/apt/apt.conf.d"
CONF_FILE="${APT_CONF_DIR}/99-disable-allowunauthenticated"

# Ensure the directory exists
[ -d "${APT_CONF_DIR}" ] || mkdir -p "${APT_CONF_DIR}"

# Add or modify the configuration to disable AllowUnauthenticated
echo 'APT::Get::AllowUnauthenticated "false";' > "${CONF_FILE}"

