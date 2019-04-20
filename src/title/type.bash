#! /bin/bash
import_by_relative_path() {
    RELATIVE_PATH="$1"

    DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    . "$DIRNAME/$RELATIVE_PATH"
}

import_by_relative_path "../utils.bash"

check_type_empty() {
    TYPE=$1

    is_empty_string $TYPE
    is_empty_string_result=$?

    if [ $is_empty_string_result -eq 1 ]
    then
        throw "Commit TYPE cannot be empty. Received: ${TYPE}"
    fi
}

check_type_enum() {
    TYPE=$1
    ALLOWED_TYPES=$2

    is_element_in_list "$TYPE" "$ALLOWED_TYPES"
    is_element_in_list_result=$?

    if [ $is_element_in_list_result -eq 1 ]
    then
        throw "Commit TYPE \"${TYPE}\" is not allowed. Expected one of \"${ALLOWED_TYPES}\""
    fi
}

check_type_lowercase(){
    TYPE=$1
    number_of_uppercase_characters=`echo "$TYPE" | grep -E "[A-Z]+" -c -m1 -`

    if [ $number_of_uppercase_characters -gt 0 ]
    then
        throw "Commit TYPE must be all lowercase. Received ${TYPE}"
    fi
}

check_type_uppercase(){
    TYPE=$1
    number_of_lowercase_characters=`echo "$TYPE" | grep -E "[a-z]+" -c -m1 -`
    
    if [ $number_of_lowercase_characters -gt 0 ]
    then
        throw "Commit TYPE must be all uppercase. Received ${TYPE}"
    fi
}