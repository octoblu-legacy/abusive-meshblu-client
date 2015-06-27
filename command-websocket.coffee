_ = require 'lodash'
debug = require('debug')('abusive-meshblu-client')
commander = require 'commander'
Meshblu  = require 'meshblu-websocket'
MeshbluConfig = require 'meshblu-config'
packageJSON = require './package.json'

class CommandWebsocket
  run: =>
    commander
      .version packageJSON.version
      .parse process.argv
    @config = (new MeshbluConfig).toJSON()
    @initialize()

  initialize: =>
    @meshblu = new Meshblu @config

    @meshblu.on 'close', @onClose
    @meshblu.on 'error', @onError
    @meshblu.connect (error) =>
      if error?
        console.error JSON.stringify error
        @noMoreAbuse = true

      console.log 'ready'
      @startTheAbuse()

    @meshblu.ws.on 'message', (frame) =>
      debug 'message', frame

  onClose: =>
    console.error 'onClose', JSON.stringify arguments
    @noMoreAbuse = true

  onError: (error) =>
    console.error 'onError', error.message

  startTheAbuse: =>
    console.log 'startTheAbuse'
    @meshblu.once 'updated', @moreAbuse
    @meshblu.update {uuid: @config.uuid}, pigeonCount: 1
    @meshblu.device uuid: @config.uuid

  moreAbuse: =>
    debug 'moreAbuse'
    try
      @meshblu.updateDangerously {uuid: @config.uuid}, {$inc: {pigeonCount: 1}}
      setTimeout @moreAbuse, (300 * 1000) unless @noMoreAbuse
    catch error
      console.error error

module.exports = CommandWebsocket
