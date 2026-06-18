#!/bin/bash
PACKAGE="com.arlosoft.macrodroid"
PERMS=(
  "android.permission.WRITE_SECURE_SETTINGS"
  "android.permission.READ_EXTERNAL_STORAGE"
  "android.permission.WRITE_EXTERNAL_STORAGE"
  "android.permission.MODIFY_PHONE_STATE"
  "android.permission.CHANGE_WIFI_STATE"
  "android.permission.CHANGE_NETWORK_STATE"
)

for perm in "${PERMS[@]}"; do
  adb shell pm grant "$PACKAGE" "$perm"
done
