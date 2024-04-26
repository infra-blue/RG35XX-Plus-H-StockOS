#!/bin/bash

####################################################################
#                      Minimal Theme Installer                     #
#                        made by @infra-blue                       #
#    Theme: https://github.com/infra-blue/RG35XX-Plus-H-StockOS    #
####################################################################

SH_DIR="$(cd $(dirname "$0"); pwd)"
THEME_NAME=$(basename "${0%.*}")
TARGET_DIR="/mnt/vendor"
BOOT_MOUNT="/mnt/boot"
BOOT_PARTITION="/dev/mmcblk0p2"

if [ -d "${TARGET_DIR}/res1" ] && [ -d "${TARGET_DIR}/res2" ]; then
    cp -rf "${SH_DIR}/${THEME_NAME}"/res1 "${TARGET_DIR}"/
    cp -rf "${SH_DIR}/${THEME_NAME}"/res2 "${TARGET_DIR}"/
fi
sync

if [ ! -d "${BOOT_MOUNT}" ]; then
  mkdir "${BOOT_MOUNT}"
  mount "${BOOT_PARTITION}" "${BOOT_MOUNT}"

  cp -rf "${SH_DIR}/${THEME_NAME}"/boot/* "${BOOT_MOUNT}"/

  sync

  umount "${BOOT_MOUNT}"
  rmdir "${BOOT_MOUNT}"
fi
exit 0
