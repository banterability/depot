class Depot
  constructor: (options) ->
    @checkDependencies()

    @vent = {}
    @store = window.localStorage
    @keyPrefix = options?.prefix


  checkDependencies: ->
    throw "[Depot]: JSON library required" unless JSON
    throw "[Depot]: Browser requires window.localStorage support" unless window.localStorage

  # Core methods (get, set, delete)

  get: (key) ->
    @_decode @store.getItem @_buildKey(key)

  set: (key, data, options = {}) ->
    fullKey = @_buildKey key
    @store.setItem fullKey, @_encode(data)
    @_fireEvent 'keyChanged', {key: fullKey, operation: 'set', value: data} unless options.suppressEvent

  del: (key) ->
    fullKey = @_buildKey key
    @store.removeItem fullKey
    @_fireEvent 'keyDeleted', key: fullKey

  ## Array methods

  push: (key, data) ->
    value = @get(key) || []
    value.push data
    @set key, value
    # todo: fire eevent

  pop: (key) ->
    value = @get(key) || []
    poppedData = value.pop()
    @set key, value
    # todo: fire event
    poppedData # Return popped object

  len: (key) ->
    value = @get(key) || []
    value.length

  ## Counter methods

  incr: (key, incrBy = 1) ->
    newValue = @_modifyCounter key, (val) -> val + incrBy
    @_fireEvent 'keyChanged', {key: @_buildKey(key), operation: 'incr', value: newValue}
    newValue

  decr: (key, decrBy = 1) ->
    newValue = @_modifyCounter key, (val) -> val - decrBy
    @_fireEvent 'keyChanged', {key: @_buildKey(key), operation: 'decr', value: newValue}
    newValue

  _modifyCounter: (key, changeFunction) ->
    currentValue = @get(key) || 0
    if typeof currentValue == "number"
      newValue = changeFunction(currentValue)
      @set key, newValue, suppressEvent: true
      newValue
    else
      throw "Cannot perform counter operation on non-number"

  ## Encoding/decoding
  # Allows native object storage by converting everything to JSON

  _encode: (data) ->
    JSON.stringify data

  _decode: (data) ->
    JSON.parse data

  _buildKey: (key) ->
    if @_isArray key
      # Allows keys to be built from arrays of components: ````['blog', 'entries', '07may'] => 'blog:entries:07may'````
      key.unshift @keyPrefix if @keyPrefix
      key.join ":"
    else
      return "#{@keyPrefix}:#{key}" if @keyPrefix
      key

  ## Utility methods

  _fireEvent: (eventName, detail) ->
    detail.eventType = eventName
    e = new CustomEvent 'depot:keyEvent', {detail}
    window.dispatchEvent(e)

  # Lifted from Underscore.js
  _isArray: Array.isArray || (obj) ->
    toString.call(obj) == '[object Array]'

  remainingSpace: ->
    1024 * 1024 * 5 - unescape(encodeURIComponent(JSON.stringify(@store))).length

# Attach to `window` object
@Depot = Depot
