#!/usr/bin/env bats

load ../src/scope
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

# TODO: this should be tested through the public method

@test "gets scope from message with scope" {
    local -r input="feat(nospace): test test test\ntest test test";
    result=`__get_scope_from_message "$input"`;
    assert_equal "$result" "nospace";
}

@test "gets scope from message with scope (with space)" {
    local -r input="feat(with scope): test test test\ntest test test";
    result=`__get_scope_from_message "$input"`;
    assert_equal "$result" "with scope";
}

@test "get empty string if empty scope" {
    local -r input=": test test test\ntest test test";
    result=`__get_scope_from_message "$input"`;
    assert_equal "$result" "";
}
