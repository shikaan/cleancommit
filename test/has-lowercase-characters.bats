#!/usr/bin/env bats

load ../src/utils
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "returns 0 if all characters are uppercase" {
    local -r input="AAAAA"
    run has_lowercase_characters "$input"

    assert_success
}

@test "returns 1 if at least a character is lowercase" {
    local -r input="aAaaa"
    run has_lowercase_characters "$input"

    assert_failure
}
