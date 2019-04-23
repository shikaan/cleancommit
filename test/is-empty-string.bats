#!/usr/bin/env bats

load ../src/utils
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "throws error if string is empty" {
    local -r input=''
    run is_empty_string "$input";
    assert_failure
}

@test "succeeds if string is not empty" {
    local -r input='not empty'
    run is_empty_string "$input";
    assert_success
}
