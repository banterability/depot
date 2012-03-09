beforeEach ->
  @store = new LocalStorageWrapper
  window.localStorage.clear()

describe "LocalStorageWrapper", ->
  describe "wraps window.localStorage methods", ->
    describe "get()", ->
      it "calls through to the getItem method", ->
        spyOn localStorage, 'getItem'
        spyOn(JSON, 'parse').andReturn("foo")
        @store.get 'key'
        expect(localStorage.getItem).toHaveBeenCalledWith('key')

    describe "set()", ->
      it "calls through to the setItem method", ->
        spyOn localStorage, 'setItem'
        spyOn(JSON, 'stringify').andReturn("value")
        @store.set 'key', 'value'
        expect(localStorage.setItem).toHaveBeenCalledWith('key', 'value')

    describe "del()", ->
      it "calls through to the removeItem method", ->
        spyOn localStorage, 'removeItem'
        @store.del 'key'
        expect(localStorage.removeItem).toHaveBeenCalledWith('key')

  describe "converts complex types to & from JSON", ->
    beforeEach ->
      @nativeObj = {album: "Mass Romantic", band: "The New Pornographers", year: 2000}
      @jsonObj = '{"album":"Mass Romantic","band":"The New Pornographers","year":2000}'

    it "stores objects as JSON", ->
      spyOn localStorage, 'setItem'
      spyOn(JSON, 'stringify').andCallThrough()
      @store.set 'album', @nativeObj
      expect(JSON.stringify).toHaveBeenCalled()
      expect(localStorage.setItem).toHaveBeenCalledWith('album', @jsonObj)

    it "gets JSON as objects", ->
      spyOn(JSON, 'parse').andCallThrough()
      localStorage.setItem 'album', @jsonObj
      response = @store.get 'album'
      expect(JSON.parse).toHaveBeenCalled()
      expect(response).toEqual(@nativeObj)

  describe "array convenience functions", ->
    beforeEach ->
      @store.set 'sampleArray', [1,2,3,4,5]

    describe "pop()", ->
      it "pops the last element off the array", ->
        poppedObj = @store.pop 'sampleArray'
        remainingObj = @store.get 'sampleArray'
        expect(poppedObj).toEqual 5
        expect(remainingObj).toEqual [1,2,3,4]

    describe "push()", ->
      it "appends an element to the end of an array", ->
        @store.push 'sampleArray', 6
        obj = @store.get 'sampleArray'
        expect(obj).toEqual [1,2,3,4,5,6]

      it "creates a new array if the key is empty", ->
        @store.push 'newArray', 6
        obj = @store.get 'newArray'
        expect(obj).toEqual [6]

  describe "key prefixing", ->
    it "prepends a string to keys if initalized with a prefix", ->
      @store = new LocalStorageWrapper "prefix"
      spyOn localStorage, 'getItem'
      spyOn(JSON, 'parse').andReturn("foo")
      @store.get 'key'
      expect(localStorage.getItem).toHaveBeenCalledWith('prefix:key')

    it "does nothing if a prefix is not provided", ->
      spyOn localStorage, 'getItem'
      spyOn(JSON, 'parse').andReturn("foo")
      @store.get 'key'
      expect(localStorage.getItem).toHaveBeenCalledWith('key')

  describe "counters", ->
    describe "incr()", ->
      it "increments a counter and returns value" , ->
        @store.set 'existingCounter', 1
        resp = @store.incr 'existingCounter'
        expect(resp).toEqual 2
        expect(@store.get 'existingCounter').toEqual 2

      it "creates a counter if key is not defined and returns", ->
        resp = @store.incr 'undefinedCounter'
        expect(resp).toEqual 1
        expect(@store.get 'undefinedCounter').toEqual 1

      it "throws an error if a non-integer value exists for key", ->
        @store.set 'nonCounter', "foo"
        expect(=> @store.incr 'nonCounter').toThrow('Cannot perform counter operation on a non-number')
        expect(@store.get 'nonCounter').toEqual "foo"

      it "increments by a specified value", ->
        @store.set 'existingCounter', 1
        resp = @store.incr 'existingCounter', 9
        expect(resp).toEqual 10
        expect(@store.get 'existingCounter').toEqual 10

    describe "decr()", ->
      it "decrement a counter and returns value" , ->
        @store.set 'existingCounter', 2
        resp = @store.decr 'existingCounter'
        expect(resp).toEqual 1
        expect(@store.get 'existingCounter').toEqual 1

      it "creates a counter if key is not defined and returns", ->
        resp = @store.decr 'undefinedCounter'
        expect(resp).toEqual -1
        expect(@store.get 'undefinedCounter').toEqual -1

      it "throws an error if a non-integer value exists for key", ->
        @store.set 'nonCounter', "foo"
        expect(=> @store.decr 'nonCounter').toThrow('Cannot perform counter operation on a non-number')
        expect(@store.get 'nonCounter').toEqual "foo"

      it "decrement by a specified value", ->
        @store.set 'existingCounter', 10
        resp = @store.decr 'existingCounter', 9
        expect(resp).toEqual 1
        expect(@store.get 'existingCounter').toEqual 1
