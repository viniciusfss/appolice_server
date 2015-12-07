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

userStore.on 'userStore_do_login', (data) ->
  console.log 'userStore_do_login'
  $.ajax({
    url: ajaxAPIURL + 'account/token'
    method: 'put'
    data: data
  })
  .done((data, status) ->
    console.log 'AJAX method successful!'
    localStorage.token = data.token
    RiotControl.trigger 'router_go_dashboard')
  .fail((req, error) ->
    console.log 'AJAX method failed!'
    console.log req)

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
  .fail((req, error) ->
    console.log 'AJAX method failed!'
    console.log req)
