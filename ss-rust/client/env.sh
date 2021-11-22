#!/bin/bash

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

if [[ -z ${SHADOWSOCK_SERVER} ]]; then
    #shellcheck disable=SC2016
    echo 'Please assign ${SHADOWSOCK_SERVER}'
    exit 1
fi

if [[ ! -f "${THIS_DIR}/ss-local.json" ]]; then
    envsubst "$(env | sort | sed -e 's/=.*//' -e 's/^/\$/g')" <"${THIS_DIR}/sslocal-tpl.json" | tee "${THIS_DIR}/sslocal.json"
fi

if [[ ! -x "${THIS_DIR}/v2ray-plugin" ]]; then
    curl -sL "https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz" -o - | tar -C . -I gzip -xf -
    mv "${THIS_DIR}/v2ray-plugin_linux_amd64" "${THIS_DIR}/v2ray-plugin"
fi
