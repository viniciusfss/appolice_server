'use strict'

class ClientStore

  constructor: () ->
    console.log 'Creating ClientStore'
    riot.observable @

  getClients: () ->
    self = @
    $.ajax({
      url: ajaxAPIURL + 'client/'
      method: 'get'
    })
    .done((data, status) ->
      console.log 'AJAX method successful'
      self.trigger 'clientStore_getClients_done', data
    )
    .fail((req, error) ->
      console.log 'AJAX method failed'
      console.log req.status
      self.trigger 'clientStore_getClients_error', req.status
    )

  createClient: (data) ->
    self = @
    $.ajax({
      url: ajaxAPIURL + 'client/create'
      method: 'put'
      data: data
    })
    .done((data, status) ->
      console.log 'AJAX method successful'
      self.trigger 'clientStore_getClients'
    )
    .fail((req, error) ->
      console.log 'AJAX method failed'
      console.log req.status
      self.trigger 'clientStore_createClient_error', req.status
    )

  sendMsg: (data) ->
    self = @
    dataId = data.id
    url = ajaxAPIURL + 'client/' + dataId + '/msg'
    console.log url
    $.ajax({
      url: url
      method: 'put'
      data: data
    })
    .done((data, status) ->
      console.log 'AJAX method successful: updateClient'
      self.trigger 'clientStore_sendMsg_done', data
    )
    .fail((req, error) ->
      console.log 'AJAX method failed'
      console.log req.status
      self.trigger 'clientStore_updateClient_error', req.status
    )

  updateClient: (data) ->
    self = @
    dataId = data.id
    url = ajaxAPIURL + 'client/' + dataId + '/update'
    console.log url
    $.ajax({
      url: url
      method: 'put'
      data: data
    })
    .done((data, status) ->
      console.log 'AJAX method successful: updateClient'
      self.trigger 'clientStore_getClients'
    )
    .fail((req, error) ->
      console.log 'AJAX method failed'
      console.log req.status
      self.trigger 'clientStore_updateClient_error', req.status
    )

clientStore = new ClientStore

clientStore.on 'clientStore_createClient', (client) ->
  this.createClient client

clientStore.on 'clientStore_sendMsg', (text) ->
  this.sendMsg text

clientStore.on 'clientStore_getClients', () ->
  this.getClients()

clientStore.on 'clientStore_updateClient', (client) ->
  this.updateClient client
