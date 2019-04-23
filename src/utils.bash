#! /bin/bash

__get_list_from_comma_separated_string () {
    local -r INPUT_STRING=$1

    echo ${INPUT_STRING} | sed -e 's/,/ /g' -
}

throw() {
    local -r error_message=$1

    echo "$error_message"
    exit 1
}

is_element_in_list() {
    local -r element=$1
    local -r list_as_string=$2

    if [[ -z ${list_as_string} ]]
    then
        throw "List cannot be empty"
    fi

    if [[ -z "$element" ]]
    then
        throw "Element cannot be empty"
    fi

    local -r list_as_list=`__get_list_from_comma_separated_string "$list_as_string"`;

    for i in ${list_as_list};
    do
        if [[ ${i} == ${element} ]]
        then
            return 0
        fi
    done

    return 1
}

is_empty_string() {
    local -r INPUT_STRING=$1

    if [[ -z ${INPUT_STRING} ]]
    then
        return 1
    fi

    return 0
}

get_configuration_by_type_and_key_from_file() {
    local -r TYPE=$1
    local -r KEY=$2
    local -r FILE=$3

    echo `sed -nr "/^\[$TYPE\]/ { :l /^$KEY[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" ${FILE}`
}

check_message_structure_by_message() {
    local -r message=$1;

    local -r column_occurrences=`echo "$message" | grep -E "\:" -o -c -m1 - | head -1`

    if [[ ${column_occurrences} -eq 0 || $? -gt 0 ]]
    then
        throw "Commit TYPE must be provided. Example: \"feat: commit message\""
    fi
}

check_message_chunk_by_message_chunk_and_chunk_name_and_allowed_rules_and_config_file () {
    local -r message_chunk=$1
    local -r chunk_name=$2
    local -ra allowed_rules=("${!3}")
    local -r config_file=$4

    for rule in ${allowed_rules[@]}
    do
        rule_argument=`get_configuration_by_type_and_key_from_file "$chunk_name" "$rule" "$config_file"`
        if [[ $? -eq 1 ]]
        then
            throw "Unable to parse config. Received error: \"$rule_argument\""
        fi

        if [[ ! -z ${rule_argument} ]] && [[ ${rule_argument} != "0" ]]
        then
            debug "Found rule $rule with $rule_argument"
            "__check_${chunk_name}_${rule}" "$message_chunk" "$rule_argument"
        fi
    done
}
