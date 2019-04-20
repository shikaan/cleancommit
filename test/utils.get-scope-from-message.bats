#!/usr/bin/env bats

load ../src/utils
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "gets scope from message with scope" {
    INPUT="feat(test): test test test\ntest test test";
    result=`get_scope_from_message "$INPUT"`;
    assert_equal "$result" "test";
}

@test "get empty string if no scope" {
    INPUT="feat: test test test\ntest test test";
    result=`get_scope_from_message "$INPUT"`;
    assert_equal "$result" "";
}

@test "get empty string if empty scope" {
    INPUT="feat(): test test test\ntest test test";
    result=`get_scope_from_message "$INPUT"`;
    assert_equal "$result" "";
}

@test "throws if type is not provided" {
    INPUT="test test test\ntest test test"
    run get_scope_from_message "$INPUT"

    assert_failure
    assert_output "Commit TYPE must be provided. Example: \"feat: commit message\""
}