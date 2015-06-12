# Description:
#   Load a random rental property from VRBO based on emorrise yubikey emissions
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   There are no commands
#
# Author:
#   nzwulfin

robot.respond /(\d{6}$)/i, (msg) ->
  num = "#{msg.match[1]}"

  msg.http("http://www.vrbo.com/#{num}")
    .get() (err, res, body) ->
      if res.statusCode == 404
        msg.send 'Property #{num} not found.'
      else
        msg.send object.link
