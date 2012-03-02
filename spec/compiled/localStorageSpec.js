(function() {
  beforeEach(function() {
    return this.store = new LocalStorageWrapper;
  });
  describe("LocalStorageWrapper", function() {
    describe("wraps window.localStorage methods", function() {
      describe("get()", function() {
        return it("calls through to the getItem method", function() {
          spyOn(localStorage, 'getItem');
          spyOn(JSON, 'parse').andReturn("");
          this.store.get('key');
          return expect(localStorage.getItem).toHaveBeenCalledWith('key');
        });
      });
      describe("set()", function() {
        return it("calls through to the setItem method", function() {
          spyOn(localStorage, 'setItem');
          spyOn(JSON, 'stringify').andReturn("value");
          this.store.set('key', 'value');
          return expect(localStorage.setItem).toHaveBeenCalledWith('key', 'value');
        });
      });
      return describe("delete()", function() {
        return it("calls through to the removeItem method", function() {
          spyOn(localStorage, 'removeItem');
          this.store["delete"]('key');
          return expect(localStorage.removeItem).toHaveBeenCalledWith('key');
        });
      });
    });
    return describe("converts complex types to & from JSON", function() {
      beforeEach(function() {
        this.nativeObj = {
          album: "Mass Romantic",
          band: "The New Pornographers",
          year: 2000
        };
        return this.jsonObj = '{"album":"Mass Romantic","band":"The New Pornographers","year":2000}';
      });
      it("stores objects as JSON", function() {
        spyOn(localStorage, 'setItem');
        this.store.set('album', this.nativeObj);
        return expect(localStorage.setItem).toHaveBeenCalledWith('album', this.jsonObj);
      });
      return it("gets JSON as objects", function() {
        var response;
        localStorage.setItem('album', this.jsonObj);
        response = this.store.get('album');
        return expect(response).toEqual(this.nativeObj);
      });
    });
  });
}).call(this);
