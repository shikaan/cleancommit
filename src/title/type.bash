#! /bin/bash
DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. "$DIRNAME/../utils.bash"

check_type_empty() {
    TYPE=$1

    throw_error_message_on_empty_string "Commit type cannot be empty. Received: ${TYPE}" $TYPE;
}

check_type_enum() {
    TYPE=$1
    ALLOWED_TYPES=$2

    error_message="Commit type \"${TYPE}\" is not allowed. Expected one of ${ALLOWED_TYPES}"

    throw_error_message_on_element_not_in_list $error_message $TYPE $ALLOWED_TYPES
}

check_type_lowercase(){
    TYPE=$1
    number_of_uppercase_characters=`echo "$TYPE" | grep -E "[A-Z]+" -c -m1 -`

    if [ $number_of_uppercase_characters -gt 0 ]
    then
        throw "Type must be all lowercase. Received ${TYPE}"
    fi
}

check_type_uppercase(){
    TYPE=$1
    number_of_lowercase_characters=`echo "$TYPE" | grep -E "[a-z]+" -c -m1 -`
    
    if [ $number_of_lowercase_characters -gt 0 ]
    then
        throw "Type must be all uppercase. Received ${TYPE}"
    fi
}