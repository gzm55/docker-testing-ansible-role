#!/bin/sh

set -e
[ "$DEBUG" != true ] || set -x

cd -- "$(dirname -- "$0")/ansible"
for f in test-*.sh; do
  [ ! -r "$f" ] || . "./$f"
done
