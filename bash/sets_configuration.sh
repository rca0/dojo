#!/bin/bash

IFS=$'\n\t'

FILE='/tmp/test'
Url="https://app.mydomain.com"
httpPort="8080"

declare -a CONFIGS=(
    "${Url}|URL=http://127.0.0.1"
    "${httpPort}|httpPort=8080"
    "${chatAddress}|node.chat.url=localhost:7777"
    "${chatPort}|node.realtime.url=localhost:8888"
); 

function __setConfigs() {
    for a in ${CONFIGS[@]}; do
        FIRST_VALUE="${a%%|*}"
        PROPERTIE=$(echo ${a} | awk -F'|' '{print $2}')
        LAST_VALUE="${a##*=}"
        if [ "${FIRST_VALUE}" == "" ]; then
            echo "${PROPERTIE}" >> "${FILE}"
        else
            LAST_VALUE=${FIRST_VALUE}
            PROPERTIE=$(echo ${a} | awk -F'|' '{print $2}' | awk -F'=' '{print $1}')
            echo "${PROPERTIE}"="${LAST_VALUE}" >> "${FILE}"
        fi
    done
}
__setConfigs