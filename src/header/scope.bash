#! /bin/bash
import_by_relative_path() {
    RELATIVE_PATH="$1"

    DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    . "$DIRNAME/$RELATIVE_PATH"
}

import_by_relative_path "../utils.bash"

check_scope_empty() {
    SCOPE=$1

    is_empty_string "$SCOPE"
    is_empty_string_result=$?

    if [[ ${is_empty_string_result} -eq 1 ]]
    then
        throw "Commit SCOPE cannot be empty. Received: ${SCOPE}"
    fi
}

check_scope_enum() {
    SCOPE=$1
    ALLOWED_SCOPES=$2

    is_element_in_list "$SCOPE" "$ALLOWED_SCOPES"
    is_element_in_list_result=$?

    if [[ ${is_element_in_list_result} -eq 1 ]]
    then
        throw "Commit SCOPE \"${SCOPE}\" is not allowed. Expected one of \"${ALLOWED_SCOPES}\""
    fi
}

check_scope_lowercase(){
    SCOPE=$1
    number_of_uppercase_characters=`echo "$SCOPE" | grep -E "[A-Z]+" -c -m1 -`

    if [[ ${number_of_uppercase_characters} -gt 0 ]]
    then
        throw "Commit SCOPE must be all lowercase. Received ${SCOPE}"
    fi
}

check_scope_uppercase(){
    SCOPE=$1
    number_of_lowercase_characters=`echo "$SCOPE" | grep -E "[a-z]+" -c -m1 -`

    if [[ ${number_of_lowercase_characters} -gt 0 ]]
    then
        throw "Commit SCOPE must be all uppercase. Received ${SCOPE}"
    fi
}

check_scope_regexp(){
    SCOPE=$1
    REGEXP=$2

    number_of_matches=`echo "$SCOPE" | grep -E "$REGEXP" -c -m1 -`

    if [[ ${number_of_matches} -eq 0 ]]
    then
        throw "Commit SCOPE must match \"$REGEXP\". Received ${SCOPE}"
    fi
}
