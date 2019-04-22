#!/usr/bin/env bash

check_title_empty() {
    TITLE=$1

    is_empty_string "$TITLE"
    is_empty_string_result=$?

    if [[ ${is_empty_string_result} -eq 1 ]]
    then
        throw "Commit TITLE cannot be empty. Received: ${TITLE}"
    fi
}

check_title_lowercase(){
    TITLE=$1
    number_of_uppercase_characters=`echo "$TITLE" | grep -E "[A-Z]+" -c -m1 -`

    if [[ ${number_of_uppercase_characters} -gt 0 ]]
    then
        throw "Commit TITLE must be all lowercase. Received ${TITLE}"
    fi
}

check_title_titlecase(){
    TITLE=$1
    is_titlecase=`echo "$TITLE" | grep -P "^(?:[A-Z][^\s]*\s?)+$" -c -`

    if [[ ${is_titlecase} -eq 0 ]]
    then
        throw "Commit TITLE must be title case. Received ${TITLE}"
    fi
}

check_title_regexp(){
    TITLE=$1
    REGEXP=$2

    number_of_matches=`echo "$TITLE" | grep -E "$REGEXP" -c -m1 -`

    if [[ ${number_of_matches} -eq 0 ]]
    then
        throw "Commit TITLE must match \"$REGEXP\". Received ${TITLE}"
    fi
}
