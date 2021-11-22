#!/bin/bash

set -e

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

if [[ ! -f "${THIS_DIR}/ssserver.json" ]]; then
    envsubst "$(env | sort | sed -e 's/=.*//' -e 's/^/\$/g')" <"${THIS_DIR}/ssserver-tpl.json" | tee "${THIS_DIR}/ssserver.json"
fi

if [[ ! -x "${THIS_DIR}/v2ray-plugin" ]]; then
    curl -sL "https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz" -o - | tar -C . -I gzip -xf -
    mv "${THIS_DIR}/v2ray-plugin_linux_amd64" "${THIS_DIR}/v2ray-plugin"
fi
