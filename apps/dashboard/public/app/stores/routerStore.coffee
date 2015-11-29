'use strict'

class RouterStore
  constructor: () ->
    console.log 'Creating RouterStore'
    riot.observable @

routerStore = new RouterStore()

routerStore.on 'router_go_login', (disabled) ->
  console.log 'router_go_login'
  riot.route '//login'

routerStore.on 'router_go_forgotpass', () ->
  console.log 'router_go_forgotpass'
  riot.route '//login/forgot'
