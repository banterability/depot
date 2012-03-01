class LocalStorageWrapper
  initialize: ->
    @store = window.localStorage

  get: (key) ->
    JSON.parse @store.getItem key
  
  set: (key, obj) ->
    @store.setItem key, JSON.stringify obj

  push: (key, obj) ->
    val = @get key || []
    val.push obj
    @set key val

  pop: (key) ->
    val = @get key || []
    poppedObj = val.pop()
    @set key val
    poppedObj

  delete: (key) ->
    @store.removeItem key
