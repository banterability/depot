{spawn, exec} = require 'child_process'

option '-w', '--watch', 'continually build the localStorageWrapper library'

task 'build', 'build localStorageWrapper (library & docs)', ->
  invoke 'build:app'
  invoke 'build:docs'

task 'build:app', 'build the localStorageWrapper library', ->
  coffee = spawn 'coffee', ['-c', '-o', 'lib', 'src']
  coffee.stdout.on 'data', (data) -> console.log data.toString().trim()
  coffee.stderr.on 'data', (data) -> console.log data.toString().trim()

task 'build:docs', 'rebuild documentation with Docco', ->
  docco = spawn 'docco', ['src/localStorage.coffee']
  docco.stdout.on 'data', (data) -> console.log data.toString().trim()
  docco.stderr.on 'data', (data) -> console.log data.toString().trim()
