#!/bin/bash

SH_DIR="$(cd $(dirname "$0"); pwd)"
THEME_NAME=$(basename "${0%.*}")
TARGET_DIR="/mnt/vendor"
BOOT_MOUNT="/mnt/boot"
BATTERY_MOUNT="/mnt/boot/bat"
BOOT_PARTITION="/dev/mmcblk0p2"

if [ -d "${TARGET_DIR}/res1" ] && [ -d "${TARGET_DIR}/res2" ]; then
    cp -rf "${SH_DIR}/${THEME_NAME}"/res1 "${TARGET_DIR}"/
    cp -rf "${SH_DIR}/${THEME_NAME}"/res2 "${TARGET_DIR}"/
fi
sync

# Install boot logo and changing battery boot screen
if [ ! -d "/mnt/boot" ]; then
  mkdir /mnt/boot
  mount "${BOOT_PARTITION}" "${BOOT_MOUNT}"

  cp -rf "${SH_DIR}/${THEME_NAME}"/boot/bootlogo.bmp "${BOOT_MOUNT}"/bootlogo.bmp
  cp -rf "${SH_DIR}/${THEME_NAME}"/boot/bat/battery_charge.bmp "${BATTERY_MOUNT}"/battery_charge.bmp
  find "${BOOT_MOUNT}" -name .DS_Store -delete
  find "${BOOT_MOUNT}" -name ._* -delete

  sync

  umount "${BOOT_MOUNT}"
  rmdir /mnt/boot
fi
exit 0
