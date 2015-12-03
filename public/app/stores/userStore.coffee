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

userStore.on 'userStore_do_register', (data) ->
  console.log 'userStore_do_register'
  $.ajax ({
    url: ajaxAPIURL + 'account/create'
    method: 'put'
    data: data
  })
  .done((data, status) ->
    console.log 'AJAX method successful!'
    RiotControl.trigger 'router_go_login', 'just_created_account')
    # Here should trigger a redirect to the login page.
  .fail((req, error) ->
    console.log 'AJAX method failed!'
    console.log req)
