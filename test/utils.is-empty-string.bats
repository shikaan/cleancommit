#!/usr/bin/env bats

load ../src/utils
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "throws error if string is empty" {
    INPUT=''
    run is_empty_string "$INPUT";
    assert_failure
}

@test "succeeds if string is not empty" {
    INPUT='not empty'
    run is_empty_string "$INPUT";
    assert_success
}