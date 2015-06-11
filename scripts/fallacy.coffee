# Description:
#   Load a random logical fallacy from an array of images.
#   Based on grumpycat.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot fallacy me - Receive a Logical Fallacy
#   hubot fallacy bomb N - get N Logical Fallacies
#
# Author:
#   nzwulfin

fallacies = [
  "https://yourlogicalfallacyis.com/strawman"
  "https://yourlogicalfallacyis.com/false-cause"
  "https://yourlogicalfallacyis.com/appeal-to-emotion"
  "https://yourlogicalfallacyis.com/the-fallacy-fallacy"
  "https://yourlogicalfallacyis.com/slippery-slope"
  "https://yourlogicalfallacyis.com/ad-hominem"
  "https://yourlogicalfallacyis.com/tu-quoque"
  "https://yourlogicalfallacyis.com/personal-incredulity"
  "https://yourlogicalfallacyis.com/special-pleading"
  "https://yourlogicalfallacyis.com/loaded-question"
  "https://yourlogicalfallacyis.com/burden-of-proof"
  "https://yourlogicalfallacyis.com/ambiguity"
  "https://yourlogicalfallacyis.com/the-gamblers-fallacy"
  "https://yourlogicalfallacyis.com/bandwagon"
  "https://yourlogicalfallacyis.com/appeal-to-authority"
  "https://yourlogicalfallacyis.com/composition-division"
  "https://yourlogicalfallacyis.com/no-true-scotsman"
  "https://yourlogicalfallacyis.com/genetic"
  "https://yourlogicalfallacyis.com/black-or-white"
  "https://yourlogicalfallacyis.com/begging-the-question"
  "https://yourlogicalfallacyis.com/appeal-to-nature"
  "https://yourlogicalfallacyis.com/anecdotal"
  "https://yourlogicalfallacyis.com/the-texas-sharpshooter"
  "https://yourlogicalfallacyis.com/middle-ground"
]

module.exports = (robot) ->
  robot.respond /fallacy me/i, (msg) ->
    msg.send fallacies[Math.floor(Math.random()*fallacies.length)]

  robot.respond /fallacy bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    for i in [1..count] by 1
      msg.send fallacies[Math.floor(Math.random()*fallacies.length)]

  robot.respond /how many fallacies are there/i, (msg) ->
    msg.send "There are #{fallacies.length} logical fallacies."
