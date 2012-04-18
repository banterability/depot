(function() {
  var Depot, root;
  root = typeof exports !== "undefined" && exports !== null ? exports : this;
  Depot = (function() {
    function Depot(prefix) {
      if (prefix == null) {
        prefix = null;
      }
      this.store = window.localStorage;
      this.prefix = prefix;
    }
    Depot.prototype.get = function(key) {
      return JSON.parse(this.store.getItem(this._buildKey(key)));
    };
    Depot.prototype.set = function(key, obj) {
      return this.store.setItem(this._buildKey(key), JSON.stringify(obj));
    };
    Depot.prototype.push = function(key, obj) {
      var val;
      val = this.get(key) || [];
      val.push(obj);
      return this.set(key, val);
    };
    Depot.prototype.pop = function(key) {
      var poppedObj, val;
      val = this.get(key) || [];
      poppedObj = val.pop();
      this.set(key, val);
      return poppedObj;
    };
    Depot.prototype._changeCounter = function(key, changeFunc) {
      var newVal, val;
      val = this.get(key) || 0;
      if (typeof val === "number") {
        newVal = changeFunc(val);
        this.set(key, newVal);
        return newVal;
      } else {
        throw "Cannot perform counter operation on a non-number";
      }
    };
    Depot.prototype.incr = function(key, incrBy) {
      if (incrBy == null) {
        incrBy = 1;
      }
      return this._changeCounter(key, function(val) {
        return val + incrBy;
      });
    };
    Depot.prototype.decr = function(key, decrBy) {
      if (decrBy == null) {
        decrBy = 1;
      }
      return this._changeCounter(key, function(val) {
        return val - decrBy;
      });
    };
    Depot.prototype.del = function(key) {
      return this.store.removeItem(this._buildKey(key));
    };
    Depot.prototype._buildKey = function(key) {
      if (this.prefix) {
        return "" + this.prefix + ":" + key;
      } else {
        return key;
      }
    };
    return Depot;
  })();
  root.Depot = Depot;
}).call(this);