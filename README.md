# hubot-coderwall

A Hubot script that calls the coderwall profile API

![](http://img.f.hatena.ne.jp/images/fotolife/b/bouzuya/20141004/20141004071827.gif)

## Installation

    $ npm install git://github.com/bouzuya/hubot-coderwall.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-coderwall.git#TAG'

## Example

    bouzuya> hubot help coderwall
      hubot> hubot coderwall <username> - calls the coderwall profile API

    bouzuya> hubot coderwall bouzuya
      hubot> http://coderwall.com/bouzuya
             github: https://github.com/bouzuya
             badges: 16 (1/4)
             [1] 2014-07-02T02:17:54Z {Kona} Have at least one original repo where CoffeeScript is the dominant language
             https://d3levm2kxut31z.cloudfront.net/assets/badges/coffee-b29d9e584f3235de7710a69fce647fae.png
             [2] 2014-01-05T23:57:52Z {Honey Badger 3} Have at least three Node.js specific repos
             https://d3levm2kxut31z.cloudfront.net/assets/badges/honeybadger3-ac53d8be1c95ad841dbce412081977cc.png
             [3] 2013-12-07T11:59:28Z {Raven} Have at least one original repo where some form of shell script is the dominant language
             https://d3levm2kxut31z.cloudfront.net/assets/badges/raven-8aecd17613101357827be9f4eeb1b64a.png
             [4] 2013-11-24T22:33:25Z {Philanthropist} Truly improve developer quality of life by sharing at least 50 individual open source projects
             https://d3levm2kxut31z.cloudfront.net/assets/badges/philanthropist-876c964e9e84f164a2c9b683383e1a03.png
             [5] 2013-11-12T22:39:24Z {Honey Badger} Have at least one original Node.js-specific repo
             https://d3levm2kxut31z.cloudfront.net/assets/badges/honeybadger-57e1f9b640e1313886724b91ab072668.png
      hubot> more [y/n] ?

## Configuration

See [`src/scripts/coderwall.coffee`](src/scripts/coderwall.coffee).

## Development

`npm run`

## License

[MIT](LICENSE)

## Author

[bouzuya][user] &lt;[m@bouzuya.net][mail]&gt; ([http://bouzuya.net][url])

## Badges

[![Build Status][travis-badge]][travis]
[![Dependencies status][david-dm-badge]][david-dm]
[![Coverage Status][coveralls-badge]][coveralls]

[travis]: https://travis-ci.org/bouzuya/hubot-coderwall
[travis-badge]: https://travis-ci.org/bouzuya/hubot-coderwall.svg?branch=master
[david-dm]: https://david-dm.org/bouzuya/hubot-coderwall
[david-dm-badge]: https://david-dm.org/bouzuya/hubot-coderwall.png
[coveralls]: https://coveralls.io/r/bouzuya/hubot-coderwall
[coveralls-badge]: https://img.shields.io/coveralls/bouzuya/hubot-coderwall.svg
[user]: https://github.com/bouzuya
[mail]: mailto:m@bouzuya.net
[url]: http://bouzuya.net
