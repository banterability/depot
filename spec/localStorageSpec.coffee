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

    describe "delete()", ->
      it "calls through to the removeItem method", ->
        spyOn localStorage, 'removeItem'
        @store.delete 'key'
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
