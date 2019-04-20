#!/usr/bin/env bats

load ../src/utils
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "throws error if string is empty" {
    INPUT=''
    ERROR='error'
    run throw_error_message_on_empty_string "$ERROR" "$INPUT";
    assert_failure
    assert_output "$ERROR"
}

@test "succeeds if string is not empty" {
    INPUT='not empty'
    ERROR='error'
    run throw_error_message_on_empty_string "$ERROR" "$INPUT";
    assert_success
}