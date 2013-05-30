beforeEach ->
  window.localStorage.clear()
  @store = new Depot

describe "Depot", ->
  describe "#constructor", ->
    # throws if localstorage doesn't exist
    # throws if JSON doesn't exist

  describe "Basic key methods", ->

    describe "#get", ->
      it "calls through to native #getItem", ->
        spy = bond(window.localStorage, 'getItem').return true
        @store.get 'key'

        spy.called.should.equal 1

      it "gets an item from the store", ->
        window.localStorage.setItem 'toBeGotten', '"value"' # Needs to be JSON-encoded
        item = @store.get 'toBeGotten'

        item.should.equal 'value'

      it 'decodes a non-string object', ->
        window.localStorage.setItem 'getComplexItem', '{"anObject":[1,2,3]}' # Needs to be JSON-encoded
        item = @store.get 'getComplexItem'

        item.should.eql {anObject: [1,2,3]}


    describe "#set", ->
      it "calls through to native #setItem", ->
        spy = bond(window.localStorage, 'setItem').return true
        @store.set 'key'

        spy.called.should.equal 1

      it "sets an item in the store", ->
        @store.set 'toBeSet', 'value'
        item = window.localStorage.getItem 'toBeSet'

        item.should.equal '"value"' # Needs to be JSON-encoded

      it 'encodes a non-string object', ->
        @store.set 'setComplexItem', {anObject: [1,2,3]}
        item = window.localStorage.getItem 'setComplexItem'

        item.should.equal '{"anObject":[1,2,3]}' # Needs to be JSON-encoded

    describe "#del", ->
      it "calls through to native #removeItem", ->
        spy = bond(window.localStorage, 'removeItem').return true
        @store.del 'key'
        spy.called.should.equal 1

      it "removes an item from the store", ->
        window.localStorage.setItem 'toBeDeleted', '"value"' # Needs to be JSON-encoded
        @store.del 'toBeDeleted'
        item = window.localStorage.getItem 'toBeDeleted'

        should.equal item, null


  describe "Array methods", ->
    # pop
      # pops the last element off the array

    # push
      # appends an element to the end of an array
      # creates a new array if the key is empty

    # len
      # gets the length of the array

  describe "Counter methods", ->
    # incr
      # increments a counter and returns value
      # creates a counter if key is not defined and returns
      # throws an error if a non-integer value exists at key
      # increments by a specified value

    # decr
      # decrements a counter and returns value
      # creates a counter if key is not defined and returns
      # throws an error if a non-integer value exists at key
      # decrements by a specified value

  describe "Key prefixing", ->
    # prepends a string to keys if intialized with a prefix
    # does nothing if a prefix is not provided

  describe "Events", ->
