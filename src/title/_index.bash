#! /bin/bash

import_by_relative_path() {
    RELATIVE_PATH="$1"

    DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    . "$DIRNAME/$RELATIVE_PATH"
}

import_by_relative_path "../utils.bash"
import_by_relative_path "../config.bash"
import_by_relative_path "type.bash"
import_by_relative_path "scope.bash"

import_by_relative_path "../logger.bash"

ALLOWED_TYPE_RULES="type_empty type_lowercase type_uppercase type_enum type_regexp"
ALLOWED_SCOPE_RULES="scope_empty scope_lowercase scope_uppercase scope_enum scope_regexp"

check_title_type_by_message_and_configuration() {
    MESSAGE=$1
    CONFIGURATION_FILE=$2

    debug "check_title_type_by_message_and_configuration (MESSAGE=\"$MESSAGE\" CONFIGURATION_FILE=\"$CONFIGURATION_FILE\")"

    type=`get_type_from_message "$MESSAGE"`
    get_type_from_message_exit_code=$?

    debug "get_type_from_message $get_type_from_message_exit_code"

    if [[ ${get_type_from_message_exit_code} -eq 1 ]]
    then
        throw "Unable to parse commit message. Received error: \"$type\""
    fi

    for rule in ${ALLOWED_TYPE_RULES}
    do
        rule_argument=`get_configuration_by_type_and_key_from_file "Title" "$rule" "$CONFIGURATION_FILE"`
        if [[ $? -eq 1 ]]
        then
            throw "Unable to parse config. Received error: \"$rule_argument\""
        fi

        if [[ ! -z ${rule_argument} ]] && [[ ${rule_argument} != "0" ]]
        then
            debug "Found rule $rule with $rule_argument"
            "check_$rule" "$type" "$rule_argument"
        fi
    done
}

check_title_scope_by_message_and_configuration() {
    MESSAGE=$1
    CONFIGURATION_FILE=$2

    debug "check_title_scope_by_message_and_configuration (MESSAGE=\"$MESSAGE\" CONFIGURATION_FILE=\"$CONFIGURATION_FILE\")"

    scope=`get_scope_from_message "$MESSAGE"`
    get_scope_from_message_exit_code=$?

    debug "get_scope_from_message $get_scope_from_message_exit_code"

    if [[ ${get_scope_from_message_exit_code} -eq 1 ]]
    then
        throw "Unable to parse commit message. Received error: \"$scope\""
    fi

    for rule in ${ALLOWED_SCOPE_RULES}
    do
        rule_argument=`get_configuration_by_type_and_key_from_file "Title" "$rule" "$CONFIGURATION_FILE"`
        if [[ $? -eq 1 ]]
        then
            throw "Unable to parse config. Received error: \"$rule_argument\""
        fi

        if [[ ! -z ${rule_argument} ]] && [[ ${rule_argument} != "0" ]]
        then
            debug "Found rule $rule with $rule_argument"
            "check_$rule" "$scope" "$rule_argument"
        fi
    done
}
