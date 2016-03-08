# Description:
#   Hey, sometimes we need a reminder not to all jargony. This bot call us on it.
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   Use naughty word, get called on it.
#
# Author:
#   emorisse

# \b(core competency|one stop shop|out of the loop|out of the box|growth|leadership|off-site meeting|negotiated|cutting edge|off-line|scale|real-time|asset|ecosystem|fast track|time to market|secret sauce|agnostic|deliverable|action items|milestone|gap analysis)\b

module.exports = (robot) ->
  robot.hear /\b(core competency|one stop shop|out of the loop|out of the box|growth|leadership|off-site meeting|negotiated|cutting edge|off-line|scale|real-time|asset|ecosystem|fast track|time to market|secret sauce|agnostic|deliverable|action items|milestone|gap analysis)\b/i, (msg) ->
    bs = "#{msg.match[0]}"
    msg.send ":cow::poop: *BINGO* #{bs}"
