#!/bin/bash
#set -x

EXCEPTIONS=
ESSENTIAL="AppleALC.kext CodecCommander.kext"

source "$(dirname ${BASH_SOURCE[0]})"/_tools/_install_subs.sh
warn_about_superuser

# install tools
install_tools

# remove old kexts
remove_deprecated_kexts
# EHCI is disabled, so no need for FakePCIID_XHCIMux.kext
remove_kext FakePCIID_XHCIMux.kext
# USBXHC_y50.kext is not used anymore
remove_kext USBXHC_y50.kext

# using AppleALC.kext, remove AppleHDA injectors
remove_kext AppleHDA_ALC283.kext

# install required kexts
install_download_kexts
install_brcmpatchram_kexts
install_backlight_kexts

# using FakePCIID_Intel_HDMI_Audio for HDAU 0x0c0c
install_fakepciid_intel_hdmi_audio

# LiluFriend and kernel cache rebuild
finish_kexts

# update kexts on EFI/CLOVER/kexts/Other
update_efi_kexts

# VoodooPS2Daemon is deprecated
remove_voodoops2daemon

#EOF
