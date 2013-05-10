# Depot
#   wraps window.localStorage
#     get
#       calls through to getItem
#     set
#       calls through to setItem
#     del
#       calls through to removeItem

#   converts complex types to & from JSON
#     stores objects as json
#     gets objects as json

#   arrays
#     pop
#       pops the last element off the array
#     push
#       appends an element to the end of an array
#       creates a new array if the key is empty

#   key prefixing
#     prepends a string to keys if intialized with a prefix
#     does nothing if a prefix is not provided

#   counters
#     incr
#       increments a counter and returns value
#       creates a counter if key is not defined and returns
#       throws an error if a non-integer value exists at key
#       increments by a specified value
#     decr
#       decrements a counter and returns value
#       creates a counter if key is not defined and returns
#       throws an error if a non-integer value exists at key
#       decrements by a specified value

describe "Depot", ->
  it "should fail, as tests aren't implimented yet", ->
    1.should.equal 2