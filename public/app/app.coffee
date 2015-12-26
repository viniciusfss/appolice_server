'use strict'
ajaxAPIURL = '/api/'

$(document).ready ->
  console.log 'Initializing Riot router'
  rg.router.start()
  console.log 'Initializing Stores'
  RiotControl.addStore userStore
  RiotControl.addStore clientStore

  rg.router.add {
    name: 'login'
    url: '/login'
  }
  rg.router.add {
    name: 'login-forgot'
    url: '/login/forgot'
  }
  rg.router.add {
    name: 'register'
    url: '/register'
  }
  rg.router.add {
    name: 'register-policy'
    url: '/register/policy'
  }

  rg.router.add {
    name: 'dashboard'
    url: '/home'
  }
  
  rg.router.add {
    name: 'clients'
    url: '/clients'
  }


  riot.mount('my-app')
