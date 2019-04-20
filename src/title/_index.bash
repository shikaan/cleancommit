#! /bin/bash
DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. "$DIRNAME/../utils.bash"
. "$DIRNAME/type.bash"

ALLOWED_RULES=type_enum,type_empty,type_lowercase,type_uppercase

# TODO: replace with input from configuration
INPUT_RULES=type_enum,type_empty
MESSAGE='feat(1): test\nanother thing'

check_message_type() {
    MESSAGE=$1
    RULES=$2

    rules_as_list=`get_list_from_comma_separated_string "$RULES"`
    type=`get_type_from_message "$MESSAGE"`

    for rule in $rules_as_list
    do
        "check_$rule" "$type" "feat,fix,test"
    done
}

check_message_type "$MESSAGE" "$INPUT_RULES" 