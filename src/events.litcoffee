**Depot.Events**

Manages events that occur internally.

    class Depot.Events
      constructor: ->
        @listeners = {"*": []}

      on: (key, callback) ->
        @listeners[key] ?= []
        @listeners[key].push callback

      off: (key, callback) ->
        @listeners[key].splice(index, 1) for index, value of @listeners[key] when value is callback

      emit: (key, args...) ->
        console.log "emit called for key", key
        @listeners[key] ?= []

        if key.indexOf(":") == -1
          callback(key, args...) for callback in @listeners[key]
          callback(key, args...) for callback in @listeners["*"]
        else
          callback(key, args...) for callback in @listeners[key]
          @_splitKeyAndBubble key, args...

      _splitKeyAndBubble: (key, args...) ->
        console.log "splitting and bubbling!"
        keyParts = key.split ":"
        keyParts.pop()
        nextKey = keyParts.join ":"
        @emit nextKey, args...
