beforeEach ->
  @store = new LocalStorageWrapper

describe "LocalStorageWrapper", ->
  describe "wraps window.localStorage methods", ->
    describe "get()", ->
      it "calls through to the getItem method", ->
        spyOn localStorage, 'getItem'
        spyOn(JSON, 'parse').andReturn("")
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
      @store.set 'album', @nativeObj
      expect(localStorage.setItem).toHaveBeenCalledWith('album', @jsonObj)

    it "gets JSON as objects", ->
      localStorage.setItem 'album', @jsonObj
      response = @store.get 'album'
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
