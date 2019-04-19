#! /bin/bash
DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. "$DIRNAME/../utils.sh"

check_type_empty() {
    MESSAGE=$1

    type=`get_type_from_message $MESSAGE`;

    throw_error_message_on_empty_string "Commit type cannot be empty. Received: ${type}" $type;
}

check_type_by_enum() {
    MESSAGE=$1
    ALLOWED_TYPES=$2

    type=`get_type_from_message $MESSAGE`;
    error_message="Commit type \"${commit_type}\" is not allowed. Expected one of ${ALLOWED_TYPES}"

    throw_error_message_on_element_not_in_list $error_message $type $ALLOWED_TYPES
}