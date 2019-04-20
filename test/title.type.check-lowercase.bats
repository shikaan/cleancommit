#!/usr/bin/env bats

load ../src/title/type
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "throws if at least a character us uppercase" {
    TYPE="aaaaAaaa"
    run check_type_lowercase "$TYPE"

    assert_failure
    assert_output "Commit type must be all lowercase. Received ${TYPE}"
}

@test "succeeds if all characters are lowercase" {
    TYPE="aaaaaaa"
    run check_type_lowercase "$TYPE"

    assert_success
}