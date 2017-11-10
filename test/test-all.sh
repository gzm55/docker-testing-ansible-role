#!/bin/sh

set -e
[ "$DEBUG" != true ] || set -x

. "$(dirname -- "$0")"/test-python.sh
. "$(dirname -- "$0")"/test-ansible-all.sh
. "$(dirname -- "$0")"/test-tox-all.sh
. "$(dirname -- "$0")"/test-molecule-all.sh

molecule --version
