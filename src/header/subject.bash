#!/usr/bin/env bash

check_subject_empty() {
    SUBJECT=$1

    is_empty_string "$SUBJECT"
    is_empty_string_result=$?

    if [[ ${is_empty_string_result} -eq 1 ]]
    then
        throw "Commit SUBJECT cannot be empty. Received: ${SUBJECT}"
    fi
}

check_subject_lowercase(){
    SUBJECT=$1
    number_of_uppercase_characters=`echo "$SUBJECT" | grep -E "[A-Z]+" -c -m1 -`

    if [[ ${number_of_uppercase_characters} -gt 0 ]]
    then
        throw "Commit SUBJECT must be all lowercase. Received ${SUBJECT}"
    fi
}

check_subject_titlecase(){
    SUBJECT=$1
    is_titlecase=`echo "$SUBJECT" | grep -P "^(?:[A-Z][^\s]*\s?)+$" -c -`

    if [[ ${is_titlecase} -eq 0 ]]
    then
        throw "Commit SUBJECT must be title case. Received ${SUBJECT}"
    fi
}

check_subject_regexp(){
    SUBJECT=$1
    REGEXP=$2

    number_of_matches=`echo "$SUBJECT" | grep -E "$REGEXP" -c -m1 -`

    if [[ ${number_of_matches} -eq 0 ]]
    then
        throw "Commit SUBJECT must match \"$REGEXP\". Received ${SUBJECT}"
    fi
}
