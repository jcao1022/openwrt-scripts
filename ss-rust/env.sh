#!/bin/bash

set -e

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

# KCPTUN_VERSION=${KCPTUN_VERSION:-$(curl -s "https://api.github.com/repos/xtaci/kcptun/releases/latest" | jq -r .tag_name)}
KCPTUN_VERSION=${KCPTUN_VERSION:-v20210624}
export KCPTUN_VERSION

SHADOWSOCKS_RUST_VERSION=${SHADOWSOCKS_RUST_VERSION:-$(curl -sL "https://api.github.com/repos/shadowsocks/shadowsocks-rust/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')}
SHADOWSOCKS_RUST_VERSION=${SHADOWSOCKS_RUST_VERSION:-v1.11.2}
export SHADOWSOCKS_RUST_VERSION

V2RAY_PLUGIN_VERSION=${V2RAY_PLUGIN_VERSION:-$(curl -s "https://api.github.com/repos/shadowsocks/v2ray-plugin/releases/latest" | jq -r .tag_name)}
V2RAY_PLUGIN_VERSION=${V2RAY_PLUGIN_VERSION:-v1.3.1}
export V2RAY_PLUGIN_VERSION

if [[ -f "${THIS_DIR}/.options" ]]; then
    KCPTUN_PORT=$(grep -e "^kcptun_port=" "${THIS_DIR}/.options" | cut -d"=" -f2)
    SHADOWSOCK_PASSWORD=$(grep -e "^password=" "${THIS_DIR}/.options" | cut -d"=" -f2)
    SHADOWSOCK_PORT=$(grep -e "^port=" "${THIS_DIR}/.options" | cut -d"=" -f2)
    if grep -s -q -e "^shadowsock_server=" "${THIS_DIR}/.options"; then
        SHADOWSOCK_SERVER=$(grep -e "^shadowsock_server=" "${THIS_DIR}/.options" | cut -d"=" -f2)
    fi
else
    KCPTUN_PORT=${KCPTUN_PORT:-$((RANDOM % 30000 + 10000))}
    SHADOWSOCK_PASSWORD=${SHADOWSOCK_PASSWORD:-$(tr -cd '[:alnum:]' </dev/urandom | fold -w30 | head -n1)}
    SHADOWSOCK_PORT=${SHADOWSOCK_PORT:-$((RANDOM % 30000 + 10000))}
    {
        echo "kcptun_port=${KCPTUN_PORT}"
        echo "password=${SHADOWSOCK_PASSWORD}"
        echo "port=${SHADOWSOCK_PORT}"
        [[ -n ${SHADOWSOCK_SERVER} ]] && echo "shadowsock_server=${SHADOWSOCK_SERVER}"
    } >>"${THIS_DIR}/.options"
fi
export KCPTUN_PORT SHADOWSOCK_PASSWORD SHADOWSOCK_PORT
