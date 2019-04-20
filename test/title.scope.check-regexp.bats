#!/usr/bin/env bash

load ../src/title/scope
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "throws if regexp is not matched" {
    SCOPE="aaaa"
    REGEXP="[0-9]+"
    run check_scope_regexp "$SCOPE" "$REGEXP"

    assert_failure
    assert_output "Commit SCOPE must match \"${REGEXP}\". Received ${SCOPE}"
}

@test "succeeds if regexp is matched" {
    SCOPE="aaaa"
    REGEXP=".+"
    run check_scope_regexp "$SCOPE" "$REGEXP"

    assert_success
}
