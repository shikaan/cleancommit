#!/bin/bash

exec 3>&2 # logging stream (file descriptor 3) defaults to STDERR

readonly SILENT=0
readonly CRITICAL=1
readonly ERROR=2
readonly WARNING=3
readonly INFO=4
readonly DEBUG=5

critical() { log ${CRITICAL} "CRITICAL: $1"; }
error() { log ${ERROR} "ERROR: $1"; }
warn() { log ${WARNING} "WARNING: $1"; }
inf() { log ${INFO} "INFO: $1"; } # "info" is already a command
debug() { log ${DEBUG} "DEBUG: $1"; }

log() {
    if [[ ${LOG_LEVEL} -ge $1 ]];
    then
        local -r datestring=`date +'%Y-%m-%d %H:%M:%S'`

        echo -e "$datestring $2" | sed '2~1s/^/  /' >&3
    fi
}
