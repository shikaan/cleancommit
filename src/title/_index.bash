#! /bin/bash
DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. "$DIRNAME/type.bash"

ALLOWED_RULES=type-enum,type-empty,type-case

# TODO: replace with input from configuration
INPUT_RULES=type-enum

