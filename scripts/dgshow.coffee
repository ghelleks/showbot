# Description:
#   Grab dgshow episode urls, add links to the show notes
#
# Dependencies:
#   "node-trello": "latest"
#
# Configuration:
#   HUBOT_TRELLO_KEY - Trello application key
#   HUBOT_TRELLO_TOKEN - Trello API token
#   HUBOT_TRELLO_LIST - The list ID that you'd like to create cards for
#
# Commands:
#   hubot dgshow search <text> - First result for <text> in dgshow archives
#   hubot dgshow ep[num]- Dave and Gunnar Show Episode <num>
#   hubot dgshow latest - Most recent Dave and Gunnar Show episode 
#   hubot dgshow suggest <text> <url> - Add a link to the cutting room floor
#   hubot suggest <text> <url> - Add a link to the cutting room floor
#   hubot dgshow suggestions - Show all the suggestions so far
#
# Notes:
#   To get your key, go to: https://trello.com/1/appKey/generate
#   To get your token, go to: https://trello.com/1/authorize?key=<<your key>>&name=Hubot+Trello&expiration=never&response_type=token&scope=read,write
#   Figure out what board you want to use, grab it's id from the url (https://trello.com/board/<<board name>>/<<board id>>)
#   To get your list ID, go to: https://trello.com/1/boards/<<board id>>/lists?key=<<your key>>&token=<<your token>>  "id" elements are the list ids.
#
# Configuration:
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

  robot.respond /dgshow search (.*)/i, (msg) ->
    text = "#{msg.match[1]}"
    showSearch msg, text

  robot.respond /dgshow ep(\d+)/i, (msg) ->
    num = "#{msg.match[1]}"
    showSearch msg, "%23#{num}%3A" 


  robot.respond /(?:dgshow )?suggest (.*) (http.*)/i, (msg) ->
      cardName = msg.match[1]
      cardUrl = msg.match[2]
      suggester = msg.message.user.name
      if not cardName.length
        msg.send "You must provide a name for the link."
        return
      if not process.env.HUBOT_TRELLO_KEY
        msg.send "Error: Trello app key is not specified"
      if not process.env.HUBOT_TRELLO_TOKEN
        msg.send "Error: Trello token is not specified"
      if not process.env.HUBOT_TRELLO_LIST
        msg.send "Error: Trello list ID is not specified"
      if not (process.env.HUBOT_TRELLO_KEY and process.env.HUBOT_TRELLO_TOKEN and process.env.HUBOT_TRELLO_LIST)
         return
      createCard msg, cardName, cardUrl, suggester

  robot.respond /dgshow suggestions/i, (msg) ->
    Trello = require("node-trello")
    t = new Trello(process.env.HUBOT_TRELLO_KEY, process.env.HUBOT_TRELLO_TOKEN)
    t.get "/1/lists/"+process.env.HUBOT_TRELLO_LIST, {cards: "open"}, (err, data) ->
      if err
        msg.send "There was an error showing the list."
        return
      msg.send "Suggestions in " + data.name + ":"
      msg.send "- " + card.name + " "+card.desc for card in data.cards

createCard = (msg, cardName, cardUrl, suggester) ->
  Trello = require("node-trello")
  t = new Trello(process.env.HUBOT_TRELLO_KEY, process.env.HUBOT_TRELLO_TOKEN)
  t.post "/1/cards", {name: cardName+" (h/t "+suggester+")", desc: cardUrl, idList: process.env.HUBOT_TRELLO_LIST}, (err, data) ->
    if err
      msg.send "There was an error creating the card"
      return
    msg.send data.url

showSearch = (msg, searchText) ->
    msg.http("http://dgshow.org/wp-json/posts?filter[s]="+searchText)
      .get() (err, res, body) ->
        if res.statusCode == 404
          msg.send 'Can\'t connect to the Wordpress API.'
        else if JSON.parse(body).length == 0
          msg.send "Episode #{num} not found."
        else
          object = JSON.parse(body)[0]
          msg.send object.link
  
