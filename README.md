# Meta-STIG Yocto Layer

The meta-stig directory is an implementation of STIG (Security Technical Implementation Guide) rules based on Ubuntu 22.04 Version 2 Release 1. These STIG rules are applicable to various systems.

## Table of Contents

1. [Adding the meta-stig layer to your build](#adding-the-meta-stig-layer-to-your-build)
2. [Adding Packagegroup](#adding-packagegroup)
3. [Required custom changes](#required-custom-changes)

## Adding the meta-stig layer to your build

To add the meta-stig layer to your build, run the following command:

```bash
bitbake-layers add-layer meta-stig
```

## Adding Packagegroup

A packagegroup is created under `meta-stig/recipes-ubuntu-stig`. This packagegroup contains all the necessary recipes. To add this packagegroup to your local configuration, append the following line to your `local.conf` file:

```
IMAGE_INSTALL:append = " packagegroup-stig"
```

Some STIGs require a package manager. To enable this feature, add the following lines to your `local.conf`:

```
EXTRA_IMAGE_FEATURES += "package-management"
//Select based on the target system
IMAGE_INSTALL:append = " apt dnf rpm" 
PACKAGE_CLASSES ?= "package_deb package_rpm"
```

## Required custom changes

1. Replace the CA certificate in the STIG V-260580, under the files directory, with the required CA certificate.

2. To ensure compatibility with the chosen package management system for the target system, replace the `sources.list` file with the latest sources for the target package manager.
