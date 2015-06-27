commander   = require 'commander'
packageJSON = require './package.json'

class Command
  run: =>
    commander
      .version packageJSON.version
      .command 'websocket', 'abuse meshblu with websockets'
      .parse process.argv

    unless commander.runningCommand
      commander.outputHelp()
      process.exit 1

module.exports = Command