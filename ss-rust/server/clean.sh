#!/bin/bash

set -x

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

rm -f "${THIS_DIR}/ssserver.json"
