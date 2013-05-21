# Depot

Treat [window.localStorage][1] more like [Redis][2]

[![Build Status](https://secure.travis-ci.org/banterability/depot.png?branch=rewrite)](http://travis-ci.org/banterability/depot)

## Usage

    ```javascript
    store = new Depot
    ```

## Features

- The basics – `get`, `set`, `del`:

    ```javascript
    // tk
    ```

- Store non-string values:

    ```javascript
    store.set('album', {album: "Mass Romantic", band: "The New Pornographers", year: 2000});
    ```

- Events on key changes

    ```javascript
    // 'jennifers' = 4

    window.addEventListener('depot:keyEvent', function(ev){
        if (ev.detail.operation == 'incr'){
            console.log('Key incremented: ' + ev.detail.value + ' ' + ev.detail.key);
        }
    }, false);

    store.incr('entries');

    -> (+) 27 jennifers
    ```

- Array methods:

    ```javascript
    store.set('extracurriculars', [
        'Yankee Review',
        'French Club',
        'Model UN',
        '2nd Chorale'
    ]);
    ```

    - `pop`:

        ```javascript
        store.pop('extracurriculars')
        -> '2nd Corale'
        // 'numbers' = ['Yankee Review', 'French Club', 'Model UN']
        ```

    - `push`:

        ```javascript
        store.push('extracurriculars', 'Kite Flying Society')
        // 'numbers' = ['Yankee Review', 'French Club', 'Model UN', 'Kite Flying Society']
        ```

    - `len`:

        ```javascript
        // tk
        ```

- Simple counter manipulation with `incr` and `decr`:

    ```javascript
    // 'bottles_of_beer_on_the_wall' = 99
    store.decr('bottles_of_beer_on_the_wall')
    -> 98

    store.incr('visitors', 10)
    -> 10
    ```

- Flexibile key generation:

    ```javascript
    // tk
    ```

- Key prefixing:

    ```javascript
    var store = new Depot('myapp');
    value = store.get('username');
    // same as: window.localStorage.getItem('myapp:username');
    ```

## Events API

- Documentation to come

## Non-features

- Doesn't emulate localStorage for older browsers (and never will)

## Future development

- Feature detection
- Left-side methods on arrays (shift, unshift)
- Subscribe to changes on a single key

[1]: http://dev.w3.org/html5/webstorage/#storage
[2]: http://redis.io/commands