#!/usr/bin/env bats

load ../src/utils
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "throws error if element is not in list" {
    ELEMENT='element'
    LIST='things which are not elements'
    ERROR='error'
    run throw_error_message_on_element_not_in_list "$ERROR" "$ELEMENT" "$LIST";
    assert_failure
    assert_output $ERROR
}

@test "succeeds if element is in list" {
    ELEMENT='element'
    LIST='this include the element'
    ERROR='error'
    run throw_error_message_on_element_not_in_list "$ERROR" "$ELEMENT" "$LIST"
    assert_success
}

@test "throws error if list is empty" {
    ELEMENT='element'
    LIST=''
    ERROR='error'
    run throw_error_message_on_element_not_in_list "$ERROR" "$ELEMENT" "$LIST"
    assert_failure
    assert_output "List cannot be empty"
}

@test "throws error if element is empty" {
    ELEMENT=''
    LIST='not empty'
    ERROR='error'
    run throw_error_message_on_element_not_in_list "$ERROR" "$ELEMENT" "$LIST"
    assert_failure
    assert_output "Element cannot be empty"
}
