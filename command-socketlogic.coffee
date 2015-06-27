_ = require 'lodash'
debug = require('debug')('abusive-meshblu-client')
commander = require 'commander'
Meshblu  = require 'meshblu-websocket'
MeshbluConfig = require 'meshblu-config'
packageJSON = require './package.json'
meshblu  = require 'meshblu'

pigeonCount = 1

class CommandSocketLogic
  run: =>
    commander
      .version packageJSON.version
      .parse process.argv
    @config = (new MeshbluConfig).toJSON()
    @initialize()

  initialize: =>
    @conn = meshblu.createConnection @config
    @conn.on 'ready', =>
      console.log 'ready'
      @startTheAbuse()
    @conn.on 'notReady', =>
      console.error 'notReady'

  startTheAbuse: =>
    @conn.update {uuid: @config.uuid, pigeonCount: pigeonCount}, (error) =>
      @moreAbuse()

    setTimeout =>
      process.exit 0
    , 10000

  moreAbuse: =>
    pigeonCount += 1
    @conn.update uuid: @config.uuid, pigeonCount: pigeonCount
    setTimeout @moreAbuse, 0

  nag: =>
    @conn.device uuid: @config.uuid
    setTimeout @nag, 0

module.exports = CommandSocketLogic
