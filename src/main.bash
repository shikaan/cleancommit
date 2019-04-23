#! /bin/bash

import_by_relative_path() {
    RELATIVE_PATH="$1"

    DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    . "$DIRNAME/$RELATIVE_PATH"
}

import_by_relative_path "header/_index.bash"

CONFIG_FILE=$1
MESSAGE=$2

check_type_by_message_and_configuration "$MESSAGE" "$CONFIG_FILE"
check_scope_by_message_and_configuration "$MESSAGE" "$CONFIG_FILE"
check_subject_by_message_and_configuration "$MESSAGE" "$CONFIG_FILE"
