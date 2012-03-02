var LocalStorageWrapper;
LocalStorageWrapper = (function() {
  function LocalStorageWrapper(prefix) {
    if (prefix == null) {
      prefix = null;
    }
    this.store = window.localStorage;
    this.prefix = prefix;
  }
  LocalStorageWrapper.prototype.get = function(key) {
    return JSON.parse(this.store.getItem(this._buildKey(key)));
  };
  LocalStorageWrapper.prototype.set = function(key, obj) {
    return this.store.setItem(this._buildKey(key), JSON.stringify(obj));
  };
  LocalStorageWrapper.prototype.push = function(key, obj) {
    var val;
    val = this.get(key) || [];
    val.push(obj);
    return this.set(key, val);
  };
  LocalStorageWrapper.prototype.pop = function(key) {
    var poppedObj, val;
    val = this.get(key || []);
    poppedObj = val.pop();
    this.set(key, val);
    return poppedObj;
  };
  LocalStorageWrapper.prototype["delete"] = function(key) {
    return this.store.removeItem(this._buildKey(key));
  };
  LocalStorageWrapper.prototype._buildKey = function(key) {
    if (this.prefix) {
      return "" + this.prefix + ":" + key;
    } else {
      return key;
    }
  };
  return LocalStorageWrapper;
})();