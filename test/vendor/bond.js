// Generated by CoffeeScript 2.0.0-beta4
void function () {
  var allStubs, arrayEqual, bond, createAnonymousSpy, createReturnSpy, createThroughSpy, enhanceSpy, isFunction, nextTick, registerCleanupHook;
  isFunction = function (obj) {
    return typeof obj === 'function';
  };
  createThroughSpy = function (getValue, bondApi) {
    var spy;
    spy = function () {
      var args, isConstructor, result;
      args = Array.prototype.slice.call(arguments);
      spy.calledArgs[spy.called] = args;
      spy.called++;
      result = getValue.apply(this, args);
      isConstructor = this instanceof arguments.callee;
      if (isConstructor)
        return this;
      return result;
    };
    return enhanceSpy(spy, getValue, bondApi);
  };
  createReturnSpy = function (getValue, bondApi) {
    var spy;
    spy = function () {
      var args;
      args = Array.prototype.slice.call(arguments);
      spy.calledArgs[spy.called] = args;
      spy.called++;
      return getValue.apply(this, args);
    };
    return enhanceSpy(spy, getValue, bondApi);
  };
  createAnonymousSpy = function () {
    var returnValue, spy;
    returnValue = null;
    spy = function () {
      var args;
      args = Array.prototype.slice.call(arguments);
      spy.calledArgs[spy.called] = args;
      spy.called++;
      return returnValue;
    };
    enhanceSpy(spy);
    spy['return'] = function (newReturnValue) {
      returnValue = newReturnValue;
      return spy;
    };
    return spy;
  };
  enhanceSpy = function (spy, original, bondApi) {
    var k, v;
    spy.prototype = null != original ? original.prototype : void 0;
    spy.called = 0;
    spy.calledArgs = [];
    spy.calledWith = function (args) {
      var lastArgs;
      args = 1 <= arguments.length ? [].slice.call(arguments, 0) : [];
      if (!spy.called)
        return false;
      lastArgs = spy.calledArgs[spy.called - 1];
      return arrayEqual(args, lastArgs);
    };
    if (bondApi)
      for (k in bondApi) {
        v = bondApi[k];
        spy[k] = v;
      }
    return spy;
  };
  arrayEqual = function (A, B) {
    var a, b, i;
    for (var i$ = 0, length$ = A.length; i$ < length$; ++i$) {
      a = A[i$];
      i = i$;
      b = B[i];
      if (a !== b)
        return false;
    }
    return true;
  };
  nextTick = function () {
    if (isFunction('undefined' !== typeof process && null != process ? process.nextTick : void 0))
      return process.nextTick;
    if ('undefined' !== typeof setImmediate && null != setImmediate && isFunction(setImmediate))
      return setImmediate;
    return function (fn) {
      return setTimeout(fn, 0);
    };
  }();
  allStubs = [];
  (registerCleanupHook = function () {
    var after;
    after = 'undefined' !== typeof afterEach && null != afterEach ? afterEach : 'undefined' !== typeof testDone && null != testDone ? testDone : null != this.cleanup ? this.cleanup : function () {
      throw new Error('bond.cleanup must be specified if your test runner does not use afterEach or testDone');
    };
    return after(function () {
      var stubRestore;
      for (var i$ = 0, length$ = allStubs.length; i$ < length$; ++i$) {
        stubRestore = allStubs[i$];
        stubRestore();
      }
      return allStubs = [];
    });
  })();
  bond = function (obj, property) {
    var asyncReturn, previous, registerRestore, restore, returnMethod, through, to;
    if (arguments.length === 0)
      return createAnonymousSpy();
    previous = obj[property];
    registerRestore = function () {
      return allStubs.push(restore);
    };
    restore = function () {
      return obj[property] = previous;
    };
    to = function (newValue) {
      registerRestore();
      if (isFunction(newValue))
        newValue = createThroughSpy(newValue, this);
      obj[property] = newValue;
      return obj[property];
    };
    returnMethod = function (returnValue) {
      var returnValueFn;
      registerRestore();
      returnValueFn = function () {
        return returnValue;
      };
      obj[property] = createReturnSpy(returnValueFn, this);
      return obj[property];
    };
    asyncReturn = function (returnValues) {
      returnValues = 1 <= arguments.length ? [].slice.call(arguments, 0) : [];
      return to(function (callback) {
        var args, numArgs$;
        if ((numArgs$ = arguments.length) > 1) {
          args = [].slice.call(arguments, 0, numArgs$ - 1);
          callback = arguments[numArgs$ - 1];
        } else {
          args = [];
        }
        if (!isFunction(callback))
          throw new Error('asyncReturn expects last argument to be a function');
        return nextTick(function () {
          return callback.apply(null, [].slice.call(returnValues).concat());
        });
      });
    };
    through = function () {
      obj[property] = createThroughSpy(previous, this);
      return obj[property];
    };
    return {
      to: to,
      'return': returnMethod,
      asyncReturn: asyncReturn,
      through: through,
      restore: restore
    };
  };
  bond.version = '0.0.13';
  if ('undefined' !== typeof window && null != window)
    window.bond = bond;
  if ('undefined' !== typeof module && null != module ? module.exports : void 0)
    module.exports = bond;
}.call(this);