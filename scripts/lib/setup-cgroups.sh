#!/bin/bash

set -e -u -x

# Currently Garden sets up its own cgroups path, and expects a particular
# layout. Ideally it would just respect the host's cgroup configuration,
# to make nesting more elegant, but for now we'll just set it up beforehand,
# otherwise it trips up on the "shared subsystem" mounts.

cat /proc/self/cgroup | grep "devices\\|memory\\|cpu" | tr : " " | \
  while read _ opt dir; do
    # mount each subsystem how Garden expects it (one dir per subsystem),
    # but respect existing mount configurations (e.g. grouping subsytems)
    for s in $(echo $opt | tr , " "); do
      mkdir -p /tmp/garden-/cgroup/$s
      mount -t cgroup -o $opt cgroup /tmp/garden-/cgroup/$s
    done
  done
