#!/usr/bin/env bats

load ../src/type
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

# TODO: this should be tested through the public method

@test "gets type from message with type (no scope)" {
    local -r input="feat: test test test\ntest test test";
    result=`__get_type_from_message "$input"`;
    assert_equal "$result" "feat";
}

@test "gets type from message with type (with scope)" {
    local -r input="feat(with scope): test test test\ntest test test";
    result=`__get_type_from_message "$input"`;
    assert_equal "$result" "feat";
}

@test "get empty string if empty type" {
    local -r input=": test test test\ntest test test";
    result=`__get_type_from_message "$input"`;
    assert_equal "$result" "";
}
