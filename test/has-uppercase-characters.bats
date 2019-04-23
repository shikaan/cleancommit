#!/usr/bin/env bats

load ../src/utils
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "returns 0 if all characters are lowercase" {
    local -r input="aaaaa"
    run has_uppercase_characters "$input"

    assert_success
}

@test "returns 1 if at least a character is uppercase" {
    local -r input="Aaaaa"
    run has_uppercase_characters "$input"

    assert_failure
}
