# Description
#   A Hubot script that calls the coderwall profile API
#
# Configuration:
#   None
#
# Commands:
#   hubot coderwall <username> - calls the coderwall profile API
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  {Pager} = require '../pager'

  cache = {}

  show = (res, data) ->
    { pager, profile } = data
    badgesString = pager.currentPageItems().map (badge, i) ->
      badgeNo = i + (pager.page - 1) * pager.itemsPerPage + 1
      """
        [#{badgeNo}] #{badge.created} {#{badge.name}} #{badge.description}
        #{badge.badge}
      """
    .join '\n'
    message = """
      https://coderwall.com/#{profile.username}
      github: https://github.com/#{profile.accounts.github}
      badges: #{profile.badges.length} (#{pager.page}/#{pager.pages})
      #{badgesString}
    """
    res.send message

    data.pager.next()
    if data.pager.hasNext()
      cache[res.envelope.user.id] = data
      res.send 'more [y/n] ? '
    else
      cache[res.envelope.user.id] = null

  robot.respond /coderwall (\S+)\s*$/i, (res) ->
    username = res.match[1]
    url = "https://coderwall.com/#{username}.json"
    res.http(url).get() (err, r, body) ->
      return res.send("#{username} is not found") if r.statusCode is 404
      profile = JSON.parse body
      data =
        profile: profile
        pager: new Pager(profile.badges.sort (b1, b2) ->
          if b1.created is b2.created
            0
          else if b1.created < b2.created
            1
          else
            -1
        )
      show(res, data)

  robot.hear /^y(?:es)?$/i, (res) ->
    data = cache[res.envelope.user.id]
    return unless data
    show(res, data)

  robot.hear /^no?$/i, (res) ->
    cache[res.envelope.user.id] = null
