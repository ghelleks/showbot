# Description:
#   Grab dgshow episode urls
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot dgshow ep[num]- Dave and Gunnar Show Episode <num>
#   hubot dgshow latest - Most recent Dave and Gunnar Show episode 
#
# Author:
#   twe4ked
#   Hemanth (fixed the max issue)
#   ghelleks

module.exports = (robot) ->
  robot.respond /dgshow latest/i, (msg) ->
    msg.http("http://dgshow.org/wp-json/posts")
      .get() (err, res, body) ->
        if res.statusCode == 404
          msg.send 'Can\'t connect to the API.'
        else if JSON.parse(body).length == 0
          msg.send 'No posts!'
        else
          object = JSON.parse(body)[0]
          msg.send object.link

  robot.respond /dgshow ep(\d+)/i, (msg) ->
    num = "#{msg.match[1]}"

    msg.http("http://dgshow.org/wp-json/posts?filter[s]=%23#{num}%3A")
      .get() (err, res, body) ->
        if res.statusCode == 404
          msg.send 'Can\'t connect to the Wordpress API.'
        else if JSON.parse(body).length == 0
          msg.send "Episode #{num} not found."
        else
          object = JSON.parse(body)[0]
          msg.send object.link

