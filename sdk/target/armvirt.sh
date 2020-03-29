#!/bin/bash

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
#shellcheck disable=SC1090
source "${THIS_DIR}/functions.sh"

function pre_ops() {
    configure_passwall
    configure_ssr_plus
}

if [[ -n ${BASE_URL_PREFIX} ]]; then
    #shellcheck disable=SC2034
    BASE_URL=${BASE_URL_PREFIX}/releases/${VERSION}/targets/armvirt/64
fi
