#! /bin/bash

get_list_from_comma_separated_string () {
    INPUT_STRING=$1

    echo $(echo ${INPUT_STRING} | sed -e 's/,/ /g' -);
}

is_element_in_list() {
    ELEMENT=$1
    LIST_AS_STRING=$2

    if [[ -z ${LIST_AS_STRING} ]]
    then
        throw "List cannot be empty"
    fi

    if [[ -z "$ELEMENT" ]]
    then
        throw "Element cannot be empty"
    fi

    list_as_list=`get_list_from_comma_separated_string "$LIST_AS_STRING"`;

    for i in ${list_as_list};
    do
        if [[ "$i" == "$ELEMENT" ]]
        then
            return 0
        fi
    done

    return 1
}

get_type_from_message() {
    MESSAGE=$1

    has_column=`echo ${MESSAGE} | grep -E "\:" -o -m1 - | head -1`

    if [[ -z ${has_column} ]]
    then
        throw "Commit TYPE must be provided. Example: \"feat: commit message\""
    fi

    echo `echo ${MESSAGE} | grep -E "^[a-zA-Z]+" -o -m1 - | head -1`
}

get_scope_from_message() {
    MESSAGE=$1

    has_column=`echo ${MESSAGE} | grep -E "\:" -o -m1 - | head -1`

    if [[ -z ${has_column} ]]
    then
        throw "Commit TYPE must be provided. Example: \"feat: commit message\""
    fi

    number_of_parenthesis=`echo ${MESSAGE} | grep -E "\(|\)" -o -m1 -c - | head -1`

    if [[ ${number_of_parenthesis} -lt 1 ]]
    then
        echo ""
        return
    fi

    echo `echo ${MESSAGE} | sed -E "s/.*\((.*)\).*/\1/g" -`
}

get_title_from_message() {
    MESSAGE=$1

    has_column=`echo ${MESSAGE} | grep -E "\:" -o -m1 - | head -1`

    if [[ -z ${has_column} ]]
    then
        throw "Commit TYPE must be provided. Example: \"feat: commit message\""
    fi

    echo `echo ${MESSAGE} | sed -E "1 s/.*:\s*(.+).*/\1/" - | head -n1 -`

}

throw() {
    MESSAGE=$1

    echo "$MESSAGE"
    exit 1
}

is_empty_string() {
    INPUT_STRING=$1

    if [[ -z ${INPUT_STRING} ]]
    then
        return 1
    fi

    return 0
}
