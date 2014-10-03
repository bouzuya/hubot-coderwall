{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'coderwall', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      setTimeout done, 10 # wait for parseHelp()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex (coderwall)', ->
    describe 'valid patterns', ->
      beforeEach ->
        @callbackIndex = 0
        @tests = [
          message: '@hubot coderwall bouzuya'
          matches: ['@hubot coderwall bouzuya', 'bouzuya']
        ]

      it 'should match', ->
        @tests.forEach ({ message, matches }) =>
          callback = @sinon.spy()
          @robot.listeners[@callbackIndex].callback = callback
          sender = new User 'bouzuya', room: 'hitoridokusho'
          @robot.adapter.receive new TextMessage(sender, message)
          actualMatches = callback.firstCall.args[0].match.map((i) -> i)
          assert callback.callCount is 1
          assert.deepEqual actualMatches, matches

  describe 'listeners[1].regex (yes)', ->
    describe 'valid patterns', ->
      beforeEach ->
        @callbackIndex = 1
        @tests = [
          message: 'y'
          matches: ['y']
        ,
          message: 'Y'
          matches: ['Y']
        ,
          message: 'yes'
          matches: ['yes']
        ]

      it 'should match', ->
        @tests.forEach ({ message, matches }) =>
          callback = @sinon.spy()
          @robot.listeners[@callbackIndex].callback = callback
          sender = new User 'bouzuya', room: 'hitoridokusho'
          @robot.adapter.receive new TextMessage(sender, message)
          actualMatches = callback.firstCall.args[0].match.map((i) -> i)
          assert callback.callCount is 1
          assert.deepEqual actualMatches, matches

  describe 'listeners[2].regex (no)', ->
    describe 'valid patterns', ->
      beforeEach ->
        @callbackIndex = 2
        @tests = [
          message: 'n'
          matches: ['n']
        ,
          message: 'N'
          matches: ['N']
        ,
          message: 'no'
          matches: ['no']
        ]

      it 'should match', ->
        @tests.forEach ({ message, matches }) =>
          callback = @sinon.spy()
          @robot.listeners[@callbackIndex].callback = callback
          sender = new User 'bouzuya', room: 'hitoridokusho'
          @robot.adapter.receive new TextMessage(sender, message)
          actualMatches = callback.firstCall.args[0].match.map((i) -> i)
          assert callback.callCount is 1
          assert.deepEqual actualMatches, matches

  describe 'robot.helpCommands()', ->
    it '''
    should be ["hubot coderwall <username> - calls the coderwall profile API"]
    ''', ->
      assert.deepEqual @robot.helpCommands(), [
        "hubot coderwall <username> - calls the coderwall profile API"
      ]
