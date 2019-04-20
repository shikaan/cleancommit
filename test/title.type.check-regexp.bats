#!/usr/bin/env bash

load ../src/title/type
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "throws if regexp is not matched" {
    TYPE="aaaa"
    REGEXP="[0-9]+"
    run check_type_regexp "$TYPE" "$REGEXP"

    assert_failure
    assert_output "Commit TYPE must match \"${REGEXP}\". Received ${TYPE}"
}

@test "succeeds if regexp is matched" {
    TYPE="aaaa"
    REGEXP=".+"
    run check_type_regexp "$TYPE" "$REGEXP"

    assert_success
}
