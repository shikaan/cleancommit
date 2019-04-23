#! /bin/bash
import_by_relative_path() {
    RELATIVE_PATH="$1"

    DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    . "$DIRNAME/$RELATIVE_PATH"
}

import_by_relative_path "utils.bash"

readonly ALLOWED_SCOPE_RULES=("empty" "lowercase" "uppercase" "enum" "regexp")

#################
# Checks:
#   These methods are meant to perform the actual checks on the commit message chunk
#################

__check_scope_empty() {
    local -r scope=$1

    is_empty_string "$scope"
    is_empty_string_result=$?

    if [[ ${is_empty_string_result} -eq 1 ]]
    then
        throw "Commit SCOPE cannot be empty. Received: ${scope}"
    fi
}

__check_scope_enum() {
    SCOPE=$1
    ALLOWED_SCOPES=$2

    is_element_in_list "$SCOPE" "$ALLOWED_SCOPES"
    is_element_in_list_result=$?

    if [[ ${is_element_in_list_result} -eq 1 ]]
    then
        throw "Commit SCOPE \"${SCOPE}\" is not allowed. Expected one of \"${ALLOWED_SCOPES}\""
    fi
}

__check_scope_lowercase(){
    local -r scope=$1

    has_uppercase_characters "$scope";

    if [[ $? -eq 1 ]]
    then
        throw "Commit SCOPE must be all lowercase. Received \"${scope}\""
    fi
}

__check_scope_uppercase(){
    SCOPE=$1
    number_of_lowercase_characters=`echo "$SCOPE" | grep -E "[a-z]+" -c -m1 -`

    if [[ ${number_of_lowercase_characters} -gt 0 ]]
    then
        throw "Commit SCOPE must be all uppercase. Received ${SCOPE}"
    fi
}

__check_scope_regexp(){
    SCOPE=$1
    REGEXP=$2

    number_of_matches=`echo "$SCOPE" | grep -E "$REGEXP" -c -m1 -`

    if [[ ${number_of_matches} -eq 0 ]]
    then
        throw "Commit SCOPE must match \"$REGEXP\". Received ${SCOPE}"
    fi
}

__get_scope_from_message() {
    local -r message=$1

    local -r number_of_parenthesis=`echo "$message" | grep -E "\(|\)" -o -m1 -c - | head -1`

    if [[ ${number_of_parenthesis} -lt 1 ]]
    then
        echo ""
        return
    fi

    echo `echo ${message} | sed -E "s/.*\((.*)\).*/\1/g" -`
}

check_commit_scope_by_message_and_config_file() {
    local -r message="$1"
    local -r config_file="$2"

    check_message_structure_by_message "$message";

    local -r scope=`__get_scope_from_message "$message"`
    debug "get_scope_from_message exit code: $?"

    if [[ $? -gt 0 ]]
    then
        throw "Unable to parse commit message. Received error: \"$scope\""
    fi

    # TODO: maybe we need a more readable name for this
    check_message_chunk_by_message_chunk_and_chunk_name_and_allowed_rules_and_config_file "$scope" "scope" ALLOWED_SCOPE_RULES[@] "$config_file"
}
