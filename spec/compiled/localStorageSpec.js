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
    describe("converts complex types to & from JSON", function() {
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
    return describe("array convenience functions", function() {
      beforeEach(function() {
        return this.store.set('sampleArray', [1, 2, 3, 4, 5]);
      });
      describe("pop()", function() {
        return it("pops the last element off the array", function() {
          var poppedObj, remainingObj;
          poppedObj = this.store.pop('sampleArray');
          remainingObj = this.store.get('sampleArray');
          expect(poppedObj).toEqual(5);
          return expect(remainingObj).toEqual([1, 2, 3, 4]);
        });
      });
      return describe("push()", function() {
        return it("appends an element to the end of an array", function() {
          var obj;
          this.store.push('sampleArray', 6);
          obj = this.store.get('sampleArray');
          return expect(obj).toEqual([1, 2, 3, 4, 5, 6]);
        });
      });
    });
  });
}).call(this);
