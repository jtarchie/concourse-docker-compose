#!/bin/bash

set -e -u -x

# make sure there are loopback devices around
for i in $(seq 0 64); do
  mknod -m 0660 /dev/loop$i b 7 $i >/dev/null || true
done

# create a large sparse file to back the btrfs mount
truncate -s 1T /garden/store

# acquire and associate a loopback device
lo=$(losetup -f --show /garden/store)

# release loopback device on exit, so this container can be cleanly reaped
# (loopback devices are global to the host system!)
trap "losetup -d $lo" EXIT

# set up btrfs
mkfs.btrfs --nodiscard $lo

# set up graph dir
mkdir -p /garden/graph
mount -t btrfs $lo /garden/graph
