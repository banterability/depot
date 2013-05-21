{spawn, exec} = require 'child_process'

task 'build', 'build depot (lib, tests & docs)', ->
  invoke 'build:lib'
  invoke 'build:tests'
  invoke 'build:docs'

task 'build:lib', 'build the depot library', ->
  console.log "Building app..."
  runner 'coffee', ['-c', '-o', 'build', 'src']

task 'build:tests', 'build the tests', ->
  console.log "Building tests..."
  runner 'coffee', ['-c', '-o', 'test/build', 'test/src']

task 'build:docs', 'build documentation with Docco', ->
  console.log "Building documentation..."
  runner 'docco', ['src/depot.litcoffee']

task 'test', 'run tests in browser', ->
  runner 'open', ['test/mocha.html']

runner = (cmd, args) ->
  worker = spawn cmd, args
  worker.stdout.on 'data', (data) -> console.log data.toString().trim()
  worker.stderr.on 'data', (data) -> console.log data.toString().trim()
