#!/usr/bin/env node

require('coffee-script/register');
var Command = require('./command-socketio.coffee');

if(require.main == module){
  (new Command()).run();
} else {
  module.exports = Command;
}
