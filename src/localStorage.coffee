class LocalStorageWrapper
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
    val = @get key || []  # Don't double-wrap key
    # Save popped object for return
    poppedObj = val.pop()
    @set key, val         # Don't double-wrap key
    poppedObj

  delete: (key) ->
    @store.removeItem @_buildKey(key)

  _buildKey: (key) ->
    if @prefix
      "#{@prefix}:#{key}"
    else
      key