#!/usr/bin/env bats

load ../src/utils
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "gets type from message with type (no scope)" {
    INPUT="feat: test test test\ntest test test";
    result=`get_type_from_message "$INPUT"`;
    assert_equal "$result" "feat";
}

@test "gets type from message with type (with scope)" {
    INPUT="feat(with scope): test test test\ntest test test";
    result=`get_type_from_message "$INPUT"`;
    assert_equal "$result" "feat";
}

@test "get empty string if empty type" {
    INPUT=": test test test\ntest test test";
    result=`get_type_from_message "$INPUT"`;
    assert_equal "$result" "";
}

@test "throws if type is not provided" {
    INPUT="test test test\ntest test test"
    run get_type_from_message "$INPUT"

    assert_failure
    assert_output "Commit TYPE must be provided. Example: \"feat: commit message\""
}