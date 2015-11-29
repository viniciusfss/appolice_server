'use strict'

class UserStore

  constructor: (@token) ->
    console.log 'Creating UserStore'
    riot.observable @

userStore = new UserStore localStorage.token

userStore.on 'userStore_check_token', () ->
  console.log 'userStore_check_token: ' + @.token
  unless @.token?
    @.trigger ''

userStore.on 'userStore_do_login', () ->
  console.log 'userStore_do_login'

