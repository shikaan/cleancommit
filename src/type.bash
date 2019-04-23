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
    local -r type=$1

    is_empty_string "$type"
    is_empty_string_result=$?

    if [[ ${is_empty_string_result} -eq 1 ]]
    then
        throw "Commit TYPE cannot be empty. Received: ${type}"
    fi
}

__check_type_enum() {
    local -r type=$1
    local -r allowed_types=$2

    is_element_in_list "$type" "$allowed_types"
    is_element_in_list_result=$?

    if [[ ${is_element_in_list_result} -eq 1 ]]
    then
        throw "Commit TYPE \"${type}\" is not allowed. Expected one of \"${allowed_types}\""
    fi
}

__check_type_lowercase(){
    local -r type=$1

    has_uppercase_characters "$type";

    if [[ $? -eq 1 ]]
    then
        throw "Commit TYPE must be all lowercase. Received \"${type}\""
    fi
}

__check_type_uppercase(){
    local -r type=$1

    has_lowercase_characters "$type";

    if [[ $? -eq 1 ]]
    then
        throw "Commit TYPE must be all uppercase. Received \"${type}\""
    fi
}

__check_type_regexp(){
    local -r scope=$1
    local -r regexp=$2

    number_of_matches=`echo "$scope" | grep -E "$regexp" -c -m1 -` #TODO: move me to a util to optimize test

    if [[ $number_of_matches -eq 0 ]]
    then
        throw "Commit TYPE must match \"$regexp\". Received ${scope}"
    fi
}

__get_type_from_message() {
    local -r message=$1

    printf "$message" | sed -E "1s/(^[a-zA-Z]*)(:|\()(.*)/\1/g" - | head -1
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
