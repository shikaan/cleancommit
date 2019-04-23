#! /bin/bash

import_by_relative_path() {
    RELATIVE_PATH="$1"

    DIRNAME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

    . "$DIRNAME/$RELATIVE_PATH"
}

import_by_relative_path "logger.bash"
import_by_relative_path "utils.bash"

import_by_relative_path "type.bash"
import_by_relative_path "scope.bash"
import_by_relative_path "subject.bash"

readonly CONFIG_FILE=$1
readonly MESSAGE=$2

check_commit_type_by_message_and_config_file "$MESSAGE" "$CONFIG_FILE"
check_commit_scope_by_message_and_config_file "$MESSAGE" "$CONFIG_FILE"
check_commit_subject_by_message_and_config_file "$MESSAGE" "$CONFIG_FILE"

