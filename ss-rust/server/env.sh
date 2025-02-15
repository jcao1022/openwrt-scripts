#!/bin/bash

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

if [[ ! -f "${THIS_DIR}/ssserver-rust.json" ]]; then
    envsubst "$(env | sort | sed -e 's/=.*//' -e 's/^/\$/g')" <"${THIS_DIR}/ssserver-rust-tpl.json" | tee "${THIS_DIR}/ssserver-rust.json"
fi
