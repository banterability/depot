# Depot

Treat [window.localStorage][1] more like [Redis][2]

[![Build Status](https://secure.travis-ci.org/banterability/depot.png?branch=events-api)](http://travis-ci.org/banterability/depot)

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
        -> '2nd Chorale'
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
    // key 'bottlesOfBeerOnTheWall' = 99
    store.decr('bottlesOfBeerOnTheWall')
    -> 98

    store.incr('visitors', 10)
    -> 10
    ```

- Key prefixing:

    ```javascript
    var store = new Depot('myapp');
    value = store.get('username');
    // same as: window.localStorage.getItem('myapp:username');
    ```

## Non-features

- Doesn't emulate localStorage for older browsers (and never will)

## Future development

- Events API

[1]: http://dev.w3.org/html5/webstorage/#storage
[2]: http://redis.io/commands