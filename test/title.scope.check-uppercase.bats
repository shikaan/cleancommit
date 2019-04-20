#!/usr/bin/env bats

load ../src/title/scope
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "throws if at least a character us lowercase" {
    SCOPE="AAAAAAaAAAA"
    run check_scope_uppercase "$SCOPE"

    assert_failure
    assert_output "Commit SCOPE must be all uppercase. Received ${SCOPE}"
}

@test "succeeds if all characters are uppercase" {
    SCOPE="AAAAA"
    run check_scope_uppercase "$SCOPE"

    assert_success
}