#! /bin/bash -x

get_list_from_comma_separated_string () {
    INPUT_STRING=$1

    echo $(echo $INPUT_STRING | sed -e 's/,/ /g' -);
}

element_in_list() {
    ELEMENT=$1
    LIST_AS_STRING=$2

    list_as_list=`get_list_from_comma_separated_string "$LIST_AS_STRING"`;

    for i in $list_as_list;
    do
        if [ $i == $ELEMENT ]
        then
            return 1
        fi
    done

    return 0
}

get_type_from_message() {
    MESSAGE=$1

    has_column=`echo $MESSAGE | grep -E "\:" -o -m1 - | head -1`

    if [ -z $has_column ]
    then
        throw "Type must be provided. Example: \"feat: commit message\""
    fi

    echo `echo $MESSAGE | grep -E "^[a-zA-Z]+" -o -m1 - | head -1`
}

throw() {
    MESSAGE=$1
    CODE=$2

    actual_code=1

    if [ -n $CODE ]
    then
        :
    else
        actual_code="$CODE"
    fi

    echo "$MESSAGE"
    exit $actual_code
}

throw_error_message_on_empty_string() {
    ERROR_MESSAGE=$1
    INPUT_STRING=$2

    if [ -z $INPUT_STRING ]
    then
        throw "$ERROR_MESSAGE"
    fi
}

throw_error_message_on_element_not_in_list() {
    ERROR_MESSAGE=$1
    ELEMENT=$2
    LIST=$3

    if [[ -z ${LIST} ]]
    then
        throw "List cannot be empty" 
    fi

    if [ -z $ELEMENT ]
    then
        throw "Element cannot be empty" 
    fi

    element_in_list "$ELEMENT" "$LIST";
    is_element_in_list=$?

    if [ $is_element_in_list -eq 0 ];
    then
        throw "$ERROR_MESSAGE"
    fi
}