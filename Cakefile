{spawn, exec} = require 'child_process'

task 'build', 'build localStorageWrapper (lib, tests & docs)', ->
  invoke 'build:lib'
  invoke 'build:tests'
  invoke 'build:docs'

task 'build:lib', 'build the localStorageWrapper library', ->
  console.log "Building app..."
  runner 'coffee', ['-b', '-c', '-o', 'lib', 'src']

task 'build:tests', 'build Jasmine tests', ->
  console.log "Building tests..."
  runner 'coffee', ['-c', '-o', 'spec/compiled', 'spec']

task 'build:docs', 'rebuild documentation with Docco', ->
  console.log "Building documentation..."
  runner 'docco', ['src/localStorage.coffee']

task 'test', 'run Jasmine tests', ->
  runner 'open', ['spec/SpecRunner.html']

runner = (cmd, args) ->
  worker = spawn cmd, args
  worker.stdout.on 'data', (data) -> console.log data.toString().trim()
  worker.stderr.on 'data', (data) -> console.log data.toString().trim()