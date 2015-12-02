'use strict'

class RouterStore
  constructor: () ->
    console.log 'Creating RouterStore'
    riot.observable @

routerStore = new RouterStore()

routerStore.on 'router_go_login', (action) ->
  console.log 'router_go_login'
  if action isnt 'no_redirect'
    riot.route '//login'

routerStore.on 'router_go_forgotpass', (action) ->
  console.log 'router_go_forgotpass'
  if action isnt 'no_redirect'
    riot.route '//login/forgot'

routerStore.on 'router_go_register', (action) ->
  if action isnt 'no_redirect'
    console.log 'router_go_register no_redirect'
    riot.route '//register'
  console.log 'router_go_register'

routerStore.on 'router_go_policy', (action) ->
  console.log 'router_go_policy'
  if action isnt 'no_redirect'
    riot.route '//register/policy'
