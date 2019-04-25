cleancommit
---

## Run tests

```
watch ./test.bash
```

## Conventions

#### Name of methods

Since we cannot have type hint for these methods, the convention is that every _noun_ in the name after _by_ is an argument in the same order are they appear.

##### Example:

`check_message_by_message_and_type_and_name` will have as argument `MESSAGE`, `TYPE`, `NAME`

#### Private methods

Methods with leading double underscore should never be used outside the file where they are defined

##### Example:

`__i_am_a_private_method`

#### Case

Local variables are lowercase, global variable are uppercase. Global variables should 
_NEVER_ be used
