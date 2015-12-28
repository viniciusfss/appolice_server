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

policyStore = new PolicyStore

policyStore.on 'policyStore_getPolicies', () ->
  this.getPolicies()