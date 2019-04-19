#!/usr/bin/env bats

load ../src/title/type
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "throws if at least a character us lowercase" {
    TYPE="AAAAAAaAAAA"
    run check_type_uppercase "$TYPE"

    assert_failure
    assert_output "Type must be all uppercase. Received ${TYPE}"
}

@test "succeeds if all characters are uppercase" {
    TYPE="AAAAA"
    run check_type_uppercase "$TYPE"

    assert_success
}