#!/usr/bin/env bash

import_by_relative_path() {
    RELATIVE_PATH="$1"

    DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    . "$DIRNAME/$RELATIVE_PATH"
}

import_by_relative_path "utils.bash"

readonly ALLOWED_SUBJECT_RULES=("empty" "lowercase" "titlecase" "regexp")

#################
# Checks:
#   These methods are meant to perform the actual checks on the commit message chunk
#################

__check_subject_empty() {
    local -r SUBJECT=$1

    is_empty_string "$SUBJECT"
    is_empty_string_result=$?

    if [[ ${is_empty_string_result} -eq 1 ]]
    then
        throw "Commit SUBJECT cannot be empty. Received: ${SUBJECT}"
    fi
}

__check_subject_lowercase(){
    SUBJECT=$1
    number_of_uppercase_characters=`echo "$SUBJECT" | grep -E "[A-Z]+" -c -m1 -`

    if [[ ${number_of_uppercase_characters} -gt 0 ]]
    then
        throw "Commit SUBJECT must be all lowercase. Received ${SUBJECT}"
    fi
}

__check_subject_titlecase(){
    SUBJECT=$1
    is_titlecase=`echo "$SUBJECT" | grep -P "^(?:[A-Z][^\s]*\s?)+$" -c -`

    if [[ ${is_titlecase} -eq 0 ]]
    then
        throw "Commit SUBJECT must be title case. Received ${SUBJECT}"
    fi
}

__check_subject_regexp(){
    SUBJECT=$1
    REGEXP=$2

    number_of_matches=`echo "$SUBJECT" | grep -E "$REGEXP" -c -m1 -`

    if [[ ${number_of_matches} -eq 0 ]]
    then
        throw "Commit SUBJECT must match \"$REGEXP\". Received ${SUBJECT}"
    fi
}

__get_subject_from_message() {
    local -r message=$1

    echo "$message" | sed -E "1 s/.*:\s*(.+).*/\1/" - | head -n1 -
}

check_commit_subject_by_message_and_config_file() {
    local -r message="$1"
    local -r config_file="$2"

    check_message_structure_by_message "$message";

    local -r subject=`__get_subject_from_message "$message"`
    debug "get_subject_from_message exit code: $?"

    if [[ $? -gt 0 ]]
    then
        throw "Unable to parse commit message. Received error: \"$subject\""
    fi

    # TODO: maybe we need a more readable name for this
    check_message_chunk_by_message_chunk_and_chunk_name_and_allowed_rules_and_config_file "$subject" "subject" ALLOWED_SUBJECT_RULES[@] "$config_file"
}
