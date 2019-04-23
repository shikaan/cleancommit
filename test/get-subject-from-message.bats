#!/usr/bin/env bats

load ../src/subject
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

# TODO: this should be tested through the public method

@test "gets subject from message with scope" {
    local -r input="feat(test): test test test\ntest test test";
    result=`__get_subject_from_message "$input"`;
    assert_equal "$result" "test test test";
}

@test "gets empty string if no subject" {
    local -r input="feat: ";
    result=`__get_subject_from_message "$input"`;
    assert_equal "$result" "";
}
