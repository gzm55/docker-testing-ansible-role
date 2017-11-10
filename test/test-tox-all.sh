#!/bin/sh

set -e
[ "$DEBUG" != true ] || set -x

cd -- "$(dirname -- "$0")/tox"
for f in ??-test-*; do
  [ -d "$f" ] || continue
  echo "Checking tox for $f ..."
  cd "$f"
  tox
  rm -rf .tox
  cd ..
done
