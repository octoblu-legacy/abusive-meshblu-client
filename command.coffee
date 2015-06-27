commander   = require 'commander'
packageJSON = require './package.json'

class Command
  run: =>
    commander
      .version packageJSON.version
      .command 'socketio',    'abuse meshblu with socket.io (v2 API)'
      .command 'socketlogic', 'abuse meshblu with socket.io (v1 API)'
      .command 'websocket',   'abuse meshblu with websockets'
      .parse process.argv

    unless commander.runningCommand
      commander.outputHelp()
      process.exit 1

module.exports = Command
