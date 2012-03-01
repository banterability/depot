class LocalStorageWrapper
  initialize: ->
    @store = window.localStorage

  # Wraps window.localStorage.getItem
  # Decodes value from JSON to support native objects
  get: (key) ->
    JSON.parse @store.getItem key
  
  # Wraps window.localStorage.setItem
  # Encodes native objects to JSON before storing
  set: (key, obj) ->
    @store.setItem key, JSON.stringify obj

  push: (key, obj) ->
    val = @get key || []
    val.push obj
    @set key val

  pop: (key) ->
    val = @get key || []
    # Save popped object for return
    poppedObj = val.pop()
    @set key val
    poppedObj

  delete: (key) ->
    @store.removeItem key
