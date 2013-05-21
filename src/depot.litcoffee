**Depot**

    class Depot
      constructor: (options) ->
        @checkDependencies()
        @vent = {}
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

Accepts an optional *options* object with the following valid values:

- `suppressEvent: true`: Prevents `set` from firing an event. This is used by higher level methods that perform complex operations, but rely on `set` to actually interact with the store.

Optional

    set: (key, data, options = {}) ->
      fullKey = @_buildKey key
      @store.setItem fullKey, @_encode(data)
      @_fireEvent 'keyChanged', {key: fullKey, operation: 'set', value: data} unless options.suppressEvent

**del:** Remove a value from the store by key

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

      _fireEvent: (eventName, detail) ->
        detail.eventType = eventName
        e = new CustomEvent 'depot:keyEvent', {detail}
        window.dispatchEvent(e)

      # Lifted from Underscore.js
      _isArray: Array.isArray || (obj) ->
        toString.call(obj) == '[object Array]'

      remainingSpace: ->
        1024 * 1024 * 5 - unescape(encodeURIComponent(JSON.stringify(@store))).length

Attach **Depot** to the `window` object for access in browser.

    @Depot = Depot
