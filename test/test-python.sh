#!/bin/sh

set -e
[ "$DEBUG" != true ] || set -x

echo -n "Checking python version ..."
python    -c 'import sys; sys.exit(0 if sys.hexversion >= 0x02070000 and sys.hexversion < 0x02080000 else 1)' && echo OK
echo -n "Checking python2 version ..."
python2   -c 'import sys; sys.exit(0 if sys.hexversion >= 0x02070000 and sys.hexversion < 0x02080000 else 1)' && echo OK
echo -n "Checking python2.7 version ..."
python2.7 -c 'import sys; sys.exit(0 if sys.hexversion >= 0x02070000 and sys.hexversion < 0x02080000 else 1)' && echo OK

echo -n "Checking python3 version ..."
python3   -c 'import sys; sys.exit(0 if sys.hexversion >= 0x03060000 and sys.hexversion < 0x03070000 else 1)' && echo OK
echo -n "Checking python3.6 version ..."
python3.6 -c 'import sys; sys.exit(0 if sys.hexversion >= 0x03060000 and sys.hexversion < 0x03070000 else 1)' && echo OK

echo -n "Checking python2.6 version ..."
python2.6 -c 'import sys; sys.exit(0 if sys.hexversion >= 0x03060000 and sys.hexversion < 0x03070000 else 1)' && echo OK
echo -n "Checking python3.5 version ..."
python3.5 -c 'import sys; sys.exit(0 if sys.hexversion >= 0x03050000 and sys.hexversion < 0x03060000 else 1)' && echo OK

echo -n "Checking python version for pip ..."
pip -V | grep -qF "python 2.7" && echo OK
echo -n "Checking python version for pip2 ..."
pip2 -V | grep -qF "python 2.7" && echo OK
echo -n "Checking python version for pip2.7 ..."
pip2.7 -V | grep -qF "python 2.7" && echo OK

echo -n "Checking python version for pip3 ..."
pip3 -V | grep -qF "python 3.6" && echo OK
echo -n "Checking python version for pip2.7 ..."
pip3.6 -V | grep -qF "python 3.6" && echo OK

echo -n "Checking python version for pip2.6 ..."
pip2.6 -V | grep -qF "python 2.6" && echo OK
echo -n "Checking python version for pip3.5 ..."
pip3.5 -V | grep -qF "python 3.5" && echo OK

## ensure we don't have more than one pip version installed
## ref: https://github.com/docker-library/python/pull/100
for cmd in pip pip2 pip2.7 pip3 pip3.6 pip2.6 pip3.5; do
  echo -n "Checking $cmd install ..."
  [ ":$($cmd list --format=columns | awk '$1 == "pip" {c++} END {print c}')" = ":1" ] && echo OK
done
