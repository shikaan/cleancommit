#!/usr/bin/env bats

load ../src/utils
load libs/bats-assert/src/assert
load libs/bats-support/src/error
load libs/bats-support/src/lang
load libs/bats-support/src/output

@test "throws if element is not in list" {
    ELEMENT='element'
    LIST='things which are not elements'
    
    run is_element_in_list "$ELEMENT" "$LIST";
    assert_failure
}

@test "succeeds if element is in list" {
    ELEMENT='element'
    LIST='this include the element'

    run is_element_in_list "$ELEMENT" "$LIST"
    assert_success
}

@test "throws error if list is empty" {
    ELEMENT='element'
    LIST=''
    
    run is_element_in_list "$ELEMENT" "$LIST"
    assert_failure
    assert_output "List cannot be empty"
}

@test "throws error if element is empty" {
    ELEMENT=''
    LIST='not empty'
    
    run is_element_in_list "$ELEMENT" "$LIST"
    assert_failure
    assert_output "Element cannot be empty"
}
