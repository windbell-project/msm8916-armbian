#!/bin/sh

get_root_mount_block() {
  awk '{if ( $2 == "/" ) { print $1, $3; exit; }}' /proc/mounts
}

main() {
  # I'm a posix standard script!
  # shellcheck disable=SC2046
  set -- $(get_root_mount_block)
  BLOCK="$1"
  FSTYPE="$2"

  logger "Resizeing root block $BLOCK($FSTYPE)"
  btrfs filesystem resize max "$BLOCK"

}

main

