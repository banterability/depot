**Depot**

    class Depot
      constructor: (options) ->
        @checkDependencies()
        @store = window.localStorage
        @keyPrefix = options?.prefix

Depot requires browser support for the HTML5 localStorage API and JSON encoding/decoding. If either is missing, throw an error.

      checkDependencies: ->
        throw "[Depot]: Browser requires window.localStorage support" unless window.localStorage
        throw "[Depot]: JSON library required" unless JSON?.stringify and JSON?.parse

## Basic key methods

**get:** Get a value from the store by key

      get: (key) ->
        @_decode @store.getItem @_buildKey(key)


**set:** Store a value in the store at a specified key.

Optional

      set: (key, data) ->
        @store.setItem @_buildKey(key), @_encode(data)

**del:** Remove a value from the store by key

      del: (key) ->
        @store.removeItem @_buildKey key

## Array methods

      push: (key, data) ->
        value = @get(key) || []
        value.push data
        @set key, value

      pop: (key) ->
        value = @get(key) || []
        poppedData = value.pop()
        @set key, value
        poppedData # Return popped object

      len: (key) ->
        value = @get(key) || []
        value.length

## Counter methods

      incr: (key, incrBy = 1) ->
        @_modifyCounter key, (val) -> val + incrBy

      decr: (key, decrBy = 1) ->
        @_modifyCounter key, (val) -> val - decrBy

      _modifyCounter: (key, changeFunction) ->
        currentValue = @get(key) || 0
        if typeof currentValue == "number"
          newValue = changeFunction(currentValue)
          @set key, newValue
          newValue
        else
          throw "Cannot perform counter operation on non-number"

## Encoding/decoding

Allows native object storage by converting everything to JSON

      _encode: (data) ->
        JSON.stringify data

      _decode: (data) ->
        JSON.parse data

## Key manipulation

Supports the creation of a key from an array of parts:

```['blog', 'entries', '07may'] => 'blog:entries:07may'```

      _buildKey: (key) ->
        if @_isArray key
          key.unshift @keyPrefix if @keyPrefix
          key.join ":"
        else
          return "#{@keyPrefix}:#{key}" if @keyPrefix
          key

## Utility methods

      # Lifted from Underscore.js
      _isArray: Array.isArray || (obj) ->
        toString.call(obj) == '[object Array]'

      remainingSpace: ->
        1024 * 1024 * 5 - unescape(encodeURIComponent(JSON.stringify(@store))).length

Attach **Depot** to the `window` object for access in browser.

    @Depot = Depot
