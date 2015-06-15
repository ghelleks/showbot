# Description:
#   Load a random rental property from VRBO based on accidental yubikey emissions, probably from emorisse
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   <[0-9]{6}> Six digits yield a vrbo search
#
# Author:
#   nzwulfin

module.exports = (robot) ->
  robot.hear /^(\d{6})$/i, (msg) ->
    num = "#{msg.match[0]}"
    link = "http://www.vrbo.com/#{num}"

    msg.http(link).get() (err, res, body) ->
      if res.statusCode == 200
        msg.send link
      if res.statusCode == 404
        msg.send "No propery results for \"#{num}\", no vacation for you :("
