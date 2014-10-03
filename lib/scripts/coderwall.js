// Description
//   A Hubot script that calls the coderwall profile API
//
// Configuration:
//   None
//
// Commands:
//   hubot coderwall <username> - calls the coderwall profile API
//
// Author:
//   bouzuya <m@bouzuya.net>
//
module.exports = function(robot) {
  var Pager, cache, show;
  Pager = require('../pager').Pager;
  cache = {};
  show = function(res, data) {
    var badgesString, message, pager, profile;
    pager = data.pager, profile = data.profile;
    badgesString = pager.currentPageItems().map(function(badge, i) {
      var badgeNo;
      badgeNo = i + (pager.page - 1) * pager.itemsPerPage + 1;
      return "[" + badgeNo + "] " + badge.created + " {" + badge.name + "} " + badge.description + "\n" + badge.badge;
    }).join('\n');
    message = "https://coderwall.com/" + profile.username + "\ngithub: https://github.com/" + profile.accounts.github + "\nbadges: " + profile.badges.length + " (" + pager.page + "/" + pager.pages + ")\n" + badgesString;
    res.send(message);
    data.pager.next();
    if (data.pager.hasNext()) {
      cache[res.envelope.user.id] = data;
      return res.send('more [y/n] ? ');
    } else {
      return cache[res.envelope.user.id] = null;
    }
  };
  robot.respond(/coderwall (\S+)\s*$/i, function(res) {
    var url, username;
    username = res.match[1];
    url = "https://coderwall.com/" + username + ".json";
    return res.http(url).get()(function(err, r, body) {
      var data, profile;
      if (r.statusCode === 404) {
        return res.send("" + username + " is not found");
      }
      profile = JSON.parse(body);
      data = {
        profile: profile,
        pager: new Pager(profile.badges.sort(function(b1, b2) {
          if (b1.created === b2.created) {
            return 0;
          } else if (b1.created < b2.created) {
            return 1;
          } else {
            return -1;
          }
        }))
      };
      return show(res, data);
    });
  });
  robot.hear(/^y(?:es)?$/i, function(res) {
    var data;
    data = cache[res.envelope.user.id];
    if (!data) {
      return;
    }
    return show(res, data);
  });
  return robot.hear(/^no?$/i, function(res) {
    return cache[res.envelope.user.id] = null;
  });
};
