#! /bin/bash

get_configuration_by_type_and_key_from_file() {
    TYPE="$1"
    KEY="$2"
    FILE="$3"

    echo `sed -nr "/^\[$TYPE\]/ { :l /^$KEY[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" ${FILE}`
}
