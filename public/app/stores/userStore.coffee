'use strict'

class UserStore

  constructor: () ->
    console.log 'Creating UserStore'
    riot.observable @

userStore = new UserStore
$.ajaxSetup({
  headers: {'x-token': localStorage.token}
}) if localStorage.token

userStore.on 'userStore_check_token', () ->
  console.log 'userStore_check_token: ' + localStorage.token
  unless localStorage.token?
    rg.router.go 'login'
  else
    console.log 'userStore_check_token: Setting AJAX.'
    $.ajaxSetup({
      headers: {'x-token': localStorage.token}
    })
    rg.router.go 'dashboard'

userStore.on 'userStore_get_account_details', () ->
  $.ajax({
    url: ajaxAPIURL + 'account/'
    method: 'get'
  })
  .done((data, status) ->
    console.log 'AJAX method successful!'
    RiotControl.trigger 'userStore_get_account_details_done', data
  )
  .fail((req, error) ->
    console.log 'AJAX method failed!'
    console.log req
  )

userStore.on 'userStore_do_login', (data) ->
  console.log 'userStore_do_login'
  $.ajax({
    url: ajaxAPIURL + 'account/login'
    method: 'put'
    data: data
  })
  .done((data, status) ->
    console.log 'AJAX method successful!'
    localStorage.token = data.token
    RiotControl.trigger 'userStore_check_token'
  )
  .fail((req, error) ->
    console.log 'AJAX method failed!'
    console.log req
  )

userStore.on 'userStore_do_register', (data) ->
  console.log 'userStore_do_register'
  $.ajax ({
    url: ajaxAPIURL + 'account/create'
    method: 'put'
    data: data
  })
  .done((data, status) ->
    console.log 'AJAX method successful!'
    rg.router.go 'login', {justCreatedAccount: true}
  )
  .fail((req, error) ->
    console.log 'AJAX method failed!'
    console.log req
  )

userStore.on 'userStore_update_profile', (data) ->
  console.log 'userStore_update_profile'
  $.ajax({
    url: ajaxAPIURL + 'account/update'
    method: 'put'
    data: data
    cache: false
    contentType: false
    processData: false
  })
  .done((data, status) ->
    console.log 'AJAX method successful!'
    RiotControl.trigger 'userStore_get_account_details'
  )
  .fail((req, error) ->
    console.log 'AJAX method failed!'
    console.log req
  )