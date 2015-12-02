'use strict'
ajaxAPIURL = '/api/'

$(document).ready ->
  console.log 'Initializing Riot router'
  riot.route.start()
  console.log 'Initializing Stores'
  RiotControl.addStore userStore
  RiotControl.addStore routerStore

  riot.route '/login', () ->
    RiotControl.trigger 'router_go_login', 'no_redirect'

  riot.route '/login/forgot', () ->
    RiotControl.trigger 'router_go_forgotpass', 'no_redirect'

  riot.route '/register', () ->
    console.log 'riot.route /register'
    RiotControl.trigger 'router_go_register', 'no_redirect'

  riot.route '/register/policy', () ->
    RiotControl.trigger 'router_go_policy', 'no_redirect'


  riot.mount('my-app')
