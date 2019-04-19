#! /bin/bash
DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. "$DIRNAME/type.bash"

ALLOWED_RULES=type_enum,type_empty,type_lowercase,type_uppercase

# TODO: replace with input from configuration
INPUT_RULES=type_enum

$type=`get_type_from_message $MESSAGE`