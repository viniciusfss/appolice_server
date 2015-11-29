'use strict'
$(document).ready ->
  console.log 'Initializing Riot router'
  riot.route.start()
  console.log 'Initializing Stores'
  RiotControl.addStore userStore
  RiotControl.addStore routerStore

  riot.route '/login', () ->
    RiotControl.trigger 'router_go_login'

  riot.route '/login/forgot', () ->
    RiotControl.trigger 'router_go_forgotpass'


  riot.mount 'my-app', {pageToDisplay: 'loginPage'}
