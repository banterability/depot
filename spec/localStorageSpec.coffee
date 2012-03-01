store = new LocalStorageWrapper

describe "LocalStorageWrapper", ->

  describe "get()", ->
    it "calls through to the getItem method", ->
      spyOn(localStorage, 'getItem')
      spyOn(JSON, 'parse').andReturn("")
      store.get 'key'
      expect(localStorage.getItem).toHaveBeenCalledWith('key')

  describe "set()", ->
    it "calls through to the setItem method", ->
      spyOn(localStorage, 'setItem')
      spyOn(JSON, 'stringify').andReturn("value")
      store.set 'key', 'value'
      expect(localStorage.setItem).toHaveBeenCalledWith('key', 'value')
