'use strict'

class PolicyStore

  constructor: () ->
    console.log 'Creating PolicyStore'
    riot.observable @

  getPolicies: () ->
    self = @
    $.ajax({
      url: ajaxAPIURL + 'policy'
      method: 'get'
    })
    .done((data, status) ->
      console.log 'AJAX method successful'
      console.log data
      self.trigger 'policyStore_getPolicies_done', data
    )
    .fail((req, error) ->
      console.log 'AJAX method failed'
      console.log error
      self.trigger 'policyStore_getPolicies_error', req.status
    )

  addPolicy: (data) ->
    self = @
    urlTo = ajaxAPIURL + 'policy/' + data.clientId + '/new'
    $.ajax({
      url: urlTo
      method: 'put'
      data: data
    })
    .done((data, status) ->
      console.log 'AJAX method successful'
      console.log data
      self.trigger 'policyStore_getPolicies'
    )
    .fail((req, error) ->
      console.log 'AJAX method failed'
      console.log error
      self.trigger 'policyStore_getPolicies_error', req.status
    )

  editPolicy: (data) ->
    self = @
    console.log data
    urlTo = ajaxAPIURL + 'policy/' + data.clientId + '/edit'
    $.ajax({
      url: urlTo
      method: 'put'
      data: data
    })
    .done((data, status) ->
      console.log 'AJAX method successful'
      console.log data
      self.trigger 'policyStore_getPolicies'
    )
    .fail((req, error) ->
      console.log 'AJAX method failed'
      console.log error
      self.trigger 'policyStore_getPolicies_error', req.status
    )

policyStore = new PolicyStore

policyStore.on 'policyStore_getPolicies', () ->
  this.getPolicies()

policyStore.on 'policyStore_addPolicyToClient', (policy) ->
  this.addPolicy(policy)

policyStore.on 'policyStore_editPolicy', (policy) ->
  this.editPolicy(policy)