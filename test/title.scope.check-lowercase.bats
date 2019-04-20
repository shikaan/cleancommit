#!/usr/bin/env bats

load ../src/title/scope
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "throws if at least a character us uppercase" {
    SCOPE="aaaaAaaa"
    run check_scope_lowercase "$SCOPE"

    assert_failure
    assert_output "Commit SCOPE must be all lowercase. Received ${SCOPE}"
}

@test "succeeds if all characters are lowercase" {
    SCOPE="aaaaaaa"
    run check_scope_lowercase "$SCOPE"

    assert_success
}