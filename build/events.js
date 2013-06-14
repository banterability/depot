// Generated by CoffeeScript 1.6.2
(function() {
  var __slice = [].slice;

  Depot.Events = (function() {
    function Events() {
      this.listeners = {
        "*": []
      };
    }

    Events.prototype.on = function(key, callback) {
      var _base, _ref;

      if ((_ref = (_base = this.listeners)[key]) == null) {
        _base[key] = [];
      }
      return this.listeners[key].push(callback);
    };

    Events.prototype.off = function(key, callback) {
      var index, value, _ref, _results;

      _ref = this.listeners[key];
      _results = [];
      for (index in _ref) {
        value = _ref[index];
        if (value === callback) {
          _results.push(this.listeners[key].splice(index, 1));
        }
      }
      return _results;
    };

    Events.prototype.emit = function() {
      var args, callback, key, _base, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _ref3, _results;

      key = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      console.log("emit called for key", key);
      if ((_ref = (_base = this.listeners)[key]) == null) {
        _base[key] = [];
      }
      if (key.indexOf(":") === -1) {
        _ref1 = this.listeners[key];
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          callback = _ref1[_i];
          callback.apply(null, [key].concat(__slice.call(args)));
        }
        _ref2 = this.listeners["*"];
        _results = [];
        for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
          callback = _ref2[_j];
          _results.push(callback.apply(null, [key].concat(__slice.call(args))));
        }
        return _results;
      } else {
        _ref3 = this.listeners[key];
        for (_k = 0, _len2 = _ref3.length; _k < _len2; _k++) {
          callback = _ref3[_k];
          callback.apply(null, [key].concat(__slice.call(args)));
        }
        return this._splitKeyAndBubble.apply(this, [key].concat(__slice.call(args)));
      }
    };

    Events.prototype._splitKeyAndBubble = function() {
      var args, key, keyParts, nextKey;

      key = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      console.log("splitting and bubbling!");
      keyParts = key.split(":");
      keyParts.pop();
      nextKey = keyParts.join(":");
      return this.emit.apply(this, [nextKey].concat(__slice.call(args)));
    };

    return Events;

  })();

}).call(this);
