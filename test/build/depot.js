// Generated by CoffeeScript 1.6.2
(function() {
  beforeEach(function() {
    window.localStorage.clear();
    return this.store = new Depot;
  });

  describe("Depot", function() {
    describe("#constructor", function() {});
    describe("Basic key methods", function() {
      describe("#get", function() {
        it("calls through to native #getItem", function() {
          var spy;

          spy = bond(window.localStorage, 'getItem')["return"](true);
          this.store.get('key');
          return spy.called.should.equal(1);
        });
        it("gets an item from the store", function() {
          var item;

          window.localStorage.setItem('toBeGotten', '"value"');
          item = this.store.get('toBeGotten');
          return item.should.equal('value');
        });
        return it('decodes a non-string object', function() {
          var item;

          window.localStorage.setItem('getComplexItem', '{"anObject":[1,2,3]}');
          item = this.store.get('getComplexItem');
          return item.should.eql({
            anObject: [1, 2, 3]
          });
        });
      });
      describe("#set", function() {
        it("calls through to native #setItem", function() {
          var spy;

          spy = bond(window.localStorage, 'setItem')["return"](true);
          this.store.set('key');
          return spy.called.should.equal(1);
        });
        it("sets an item in the store", function() {
          var item;

          this.store.set('toBeSet', 'value');
          item = window.localStorage.getItem('toBeSet');
          return item.should.equal('"value"');
        });
        return it('encodes a non-string object', function() {
          var item;

          this.store.set('setComplexItem', {
            anObject: [1, 2, 3]
          });
          item = window.localStorage.getItem('setComplexItem');
          return item.should.equal('{"anObject":[1,2,3]}');
        });
      });
      return describe("#del", function() {
        it("calls through to native #removeItem", function() {
          var spy;

          spy = bond(window.localStorage, 'removeItem')["return"](true);
          this.store.del('key');
          return spy.called.should.equal(1);
        });
        return it("removes an item from the store", function() {
          var item;

          window.localStorage.setItem('toBeDeleted', '"value"');
          this.store.del('toBeDeleted');
          item = window.localStorage.getItem('toBeDeleted');
          return should.equal(item, null);
        });
      });
    });
    describe("Array methods", function() {});
    describe("Counter methods", function() {});
    return describe("Key prefixing", function() {});
  });

}).call(this);
