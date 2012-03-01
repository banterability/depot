{spawn, exec} = require 'child_process'

task 'build', 'build localStorageWrapper (library & docs)', ->
  invoke 'build:app'
  invoke 'build:docs'

task 'build:app', 'build the localStorageWrapper library', ->
  runner 'coffee', ['-c', '-o', 'lib', 'src']

task 'build:docs', 'rebuild documentation with Docco', ->
  runner 'docco', ['src/localStorage.coffee']

runner = (cmd, args) ->
  worker = spawn cmd, args
  worker.stdout.on 'data', (data) -> console.log data.toString().trim()
  worker.stderr.on 'data', (data) -> console.log data.toString().trim()