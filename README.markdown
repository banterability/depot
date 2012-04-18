# Depot

A wrapper around the [window.localStorage API][1].

## Features
- Support for non-string values:

    ```javascript
    store.set('album', {album: "Mass Romantic", band: "The New Pornographers", year: 2000});
    ```

- Array methods like pop & push:

    ```javascript
    store.set('numbers', [1, 2, 3, 4]);
    
    store.push('numbers', 5)
    // 'numbers' = [1, 2, 3, 4, 5]
    
    store.pop('numbers')
    -> 5
    // 'numbers' = [1, 2, 3, 4]
    ```

- Simple counters:

    ```javascript
    store.incr('visitors')
    -> 1

    // 'bottles_of_beer_on_the_wall' = 99
    store.decr('bottles_of_beer_on_the_wall', 3)
    -> 96
    ```

- Key prefixing:

    ```javascript
    var store = new Depot('myapp');
    value = store.get('username');
    // same as: window.localStorage.getItem('myapp:username');
    ```

## To-do
- Feature detection
- Left-side methods on arrays (shift, unshift)

## *Not* to-do
- localStorage emulation (via cookies, etc.)

[1]: http://dev.w3.org/html5/webstorage/#storage