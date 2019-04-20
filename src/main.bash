#! /bin/bash

import_by_relative_path() {
    RELATIVE_PATH="$1"

    DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    . "$DIRNAME/$RELATIVE_PATH"
}

import_by_relative_path "title/_index.bash"

CONFIG_FILE=$1
MESSAGE=$2

check_title_type_by_message_and_configuration "$MESSAGE" "$CONFIG_FILE"
check_title_scope_by_message_and_configuration "$MESSAGE" "$CONFIG_FILE"