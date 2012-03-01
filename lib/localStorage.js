var LocalStorageWrapper;
LocalStorageWrapper = (function() {
  function LocalStorageWrapper() {
    this.store = window.localStorage;
  }
  LocalStorageWrapper.prototype.get = function(key) {
    return JSON.parse(this.store.getItem(key));
  };
  LocalStorageWrapper.prototype.set = function(key, obj) {
    return this.store.setItem(key, JSON.stringify(obj));
  };
  LocalStorageWrapper.prototype.push = function(key, obj) {
    var val;
    val = this.get(key || []);
    val.push(obj);
    return this.set(key(val));
  };
  LocalStorageWrapper.prototype.pop = function(key) {
    var poppedObj, val;
    val = this.get(key || []);
    poppedObj = val.pop();
    this.set(key(val));
    return poppedObj;
  };
  LocalStorageWrapper.prototype["delete"] = function(key) {
    return this.store.removeItem(key);
  };
  return LocalStorageWrapper;
})();