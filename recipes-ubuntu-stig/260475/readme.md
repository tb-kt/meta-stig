### Verify Hardware supports NX bit

Run the command 
```
grep flags /proc/cpuinfo | grep -o nx | sort -u
```

If the output is NX, then the hardware supports it.

The configuration needs to be added to the meta base layer at this location:
```
/meta/recipes-kernel/linux
```

Create a file linux-yocto_%.bbappend in the above directory
Add the following contents to the file:
```
# Append additional configurations to the kernel
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://defconfig"

do_configure:append() {
    # Ensure NX bit protection configurations are enabled
    echo "CONFIG_X86=y" >> ${B}/.config
    echo "CONFIG_X86_64=y" >> ${B}/.config
    echo "CONFIG_X86_PAE=y" >> ${B}/.config
}
```



