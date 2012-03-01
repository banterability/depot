# localStorageWrapper

A wrapper around the [window.localStorage API][1] supporting non-string types & convenience methods like pop & push.

## To-do
- Feature detection
- Key prefixing
- Left-side methods on arrays (shift, unshift)
- More unit tests
- Restore [safety wrapper][2] to library

## *Not* to-do
- localStorage emulation (via cookies, etc.)

[1]: http://dev.w3.org/html5/webstorage/#storage
[2]: http://coffeescript.org/#lexical_scope