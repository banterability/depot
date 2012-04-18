root = exports ? this

class Depot
  constructor: (prefix = null)->
    @store = window.localStorage
    @prefix = prefix

  # Wraps window.localStorage.getItem
  # Decodes value from JSON to support native objects
  get: (key) ->
    JSON.parse @store.getItem @_buildKey(key)
  
  # Wraps window.localStorage.setItem
  # Encodes native objects to JSON before storing
  set: (key, obj) ->
    @store.setItem @_buildKey(key), JSON.stringify obj

  push: (key, obj) ->
    val = @get(key) || []  # Don't double-wrap key
    val.push obj
    @set key, val         # Don't double-wrap key

  pop: (key) ->
    val = @get(key) || []  # Don't double-wrap key
    # Save popped object for return
    poppedObj = val.pop()
    @set key, val         # Don't double-wrap key
    poppedObj

  # Handle counter operations (incr & decr)
  # Accepts a key and a function that modifies the existing counter value
  _changeCounter: (key, changeFunc) ->
    val = @get(key) || 0
    if typeof val == "number"
      newVal = changeFunc(val)
      @set key, newVal
      newVal
    else
      throw "Cannot perform counter operation on a non-number"

  incr: (key, incrBy = 1) ->
    @_changeCounter key, (val) -> val + incrBy

  decr: (key, decrBy = 1) ->
    @_changeCounter key, (val) -> val - decrBy

  del: (key) ->
    @store.removeItem @_buildKey(key)

  _buildKey: (key) ->
    if @prefix
      "#{@prefix}:#{key}"
    else
      key

root.Depot = Depot