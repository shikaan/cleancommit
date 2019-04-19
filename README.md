cleancommit
---

## Run tests

```
watch ./test.sh
```

## Conventions

#### Name of methods

Since we cannot have type hint for these methods, the convention is that every _noun_ in the name is an argument in the same order are they appear.

##### Example:

`throw_error_if_element_not_in_list` will have as argument `ERROR`, `ELEMENT`, `LIST`