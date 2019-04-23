#! /bin/bash
import_by_relative_path() {
    RELATIVE_PATH="$1"

    DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    . "$DIRNAME/$RELATIVE_PATH"
}

import_by_relative_path "utils.bash"

readonly ALLOWED_TYPE_RULES=("empty" "lowercase" "uppercase" "enum" "regexp")

#################
# Checks:
#   These methods are meant to perform the actual checks on the commit message chunk
#################

__check_type_empty() {
    local -r TYPE=$1

    is_empty_string "$TYPE"
    is_empty_string_result=$?

    if [[ ${is_empty_string_result} -eq 1 ]]
    then
        throw "Commit TYPE cannot be empty. Received: ${TYPE}"
    fi
}

__check_type_enum() {
    TYPE=$1
    ALLOWED_TYPES=$2

    is_element_in_list "$TYPE" "$ALLOWED_TYPES"
    is_element_in_list_result=$?

    if [[ ${is_element_in_list_result} -eq 1 ]]
    then
        throw "Commit TYPE \"${TYPE}\" is not allowed. Expected one of \"${ALLOWED_TYPES}\""
    fi
}

__check_type_lowercase(){
    TYPE=$1
    number_of_uppercase_characters=`echo "$TYPE" | grep -E "[A-Z]+" -c -m1 -` #TODO: move me to a util to optimize test

    if [[ ${number_of_uppercase_characters} -gt 0 ]]
    then
        throw "Commit TYPE must be all lowercase. Received ${TYPE}"
    fi
}

__check_type_uppercase(){
    TYPE=$1
    number_of_lowercase_characters=`echo "$TYPE" | grep -E "[a-z]+" -c -m1 -` #TODO: move me to a util to optimize test

    if [[ ${number_of_lowercase_characters} -gt 0 ]]
    then
        throw "Commit TYPE must be all uppercase. Received ${TYPE}"
    fi
}

__check_type_regexp(){
    SCOPE=$1
    REGEXP=$2

    number_of_matches=`echo "$SCOPE" | grep -E "$REGEXP" -c -m1 -` #TODO: move me to a util to optimize test

    if [[ $number_of_matches -eq 0 ]]
    then
        throw "Commit TYPE must match \"$REGEXP\". Received ${SCOPE}"
    fi
}

__get_type_from_message() {
    local -r message=$1

    echo "$message" | grep -E "^[a-zA-Z]+" -o -m1 - | head -1
}

check_commit_type_by_message_and_config_file() {
    local -r message="$1"
    local -r config_file="$2"

    check_message_structure_by_message "$message";

    local -r type=`__get_type_from_message "$message"`
    debug "get_type_from_message exit code: $?"

    if [[ $? -gt 0 ]]
    then
        throw "Unable to parse commit message. Received error: \"$type\""
    fi

    # TODO: maybe we need a more readable name for this
    check_message_chunk_by_message_chunk_and_chunk_name_and_allowed_rules_and_config_file "$type" "type" ALLOWED_TYPE_RULES[@] "$config_file"
}
