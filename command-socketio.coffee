_ = require 'lodash'
debug = require('debug')('abusive-meshblu-client')
commander = require 'commander'
Meshblu  = require 'meshblu-socket.io'
MeshbluConfig = require 'meshblu-config'
packageJSON = require './package.json'

class CommandSocketIO
  run: =>
    commander
      .version packageJSON.version
      .parse process.argv
    @config = (new MeshbluConfig).toJSON()
    @initialize()

  initialize: =>
    @meshblu = new Meshblu @config
    @meshblu.connect =>
      console.log 'ready'
      @startTheAbuse()

    @meshblu.on 'notReady', =>
      console.error 'notReady'

  startTheAbuse: =>
    @meshblu.update {uuid: @config.uuid}, {pigeonCount: 1}, (error) =>
      console.error error if error?
      @moreAbuse()

  moreAbuse: =>
    @meshblu.updateDangerously {uuid: @config.uuid}, {$inc: {pigeonCount: 1}}, (error) =>
      console.error error if error?
    setTimeout @moreAbuse, 1000

module.exports = CommandSocketIO
