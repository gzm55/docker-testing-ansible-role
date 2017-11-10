#!/bin/sh

set -e
[ "$DEBUG" != true ] || set -x

molecule --version

cd -- "$(dirname -- "$0")/molecule"
for f in ??-test-*; do
  [ -d "$f" ] || continue
  echo "Checking molecule on project $f ..."
  cd "$f"
  molecule test
  if [ -f tox.ini ]; then
    tox
    rm -rf .tox
  fi
  cd ..
done
