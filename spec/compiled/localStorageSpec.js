(function() {
  var store;
  store = new LocalStorageWrapper;
  describe("LocalStorageWrapper", function() {
    describe("get()", function() {
      return it("calls through to the getItem method", function() {
        spyOn(localStorage, 'getItem');
        spyOn(JSON, 'parse').andReturn("");
        store.get('key');
        return expect(localStorage.getItem).toHaveBeenCalledWith('key');
      });
    });
    return describe("set()", function() {
      return it("calls through to the setItem method", function() {
        spyOn(localStorage, 'setItem');
        spyOn(JSON, 'stringify').andReturn("value");
        store.set('key', 'value');
        return expect(localStorage.setItem).toHaveBeenCalledWith('key', 'value');
      });
    });
  });
}).call(this);
