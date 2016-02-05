// Generated by CoffeeScript 1.10.0
'use strict';
var ClientStore, clientStore;

ClientStore = (function() {
  function ClientStore() {
    console.log('Creating ClientStore');
    riot.observable(this);
  }

  ClientStore.prototype.getClients = function() {
    var self;
    self = this;
    return $.ajax({
      url: ajaxAPIURL + 'client/',
      method: 'get'
    }).done(function(data, status) {
      console.log('AJAX method successful');
      return self.trigger('clientStore_getClients_done', data);
    }).fail(function(req, error) {
      console.log('AJAX method failed');
      console.log(req.status);
      return self.trigger('clientStore_getClients_error', req.status);
    });
  };

  ClientStore.prototype.createClient = function(data) {
    var self;
    self = this;
    return $.ajax({
      url: ajaxAPIURL + 'client/create',
      method: 'put',
      data: data
    }).done(function(data, status) {
      console.log('AJAX method successful');
      return self.trigger('clientStore_getClients');
    }).fail(function(req, error) {
      console.log('AJAX method failed');
      console.log(req.status);
      return self.trigger('clientStore_createClient_error', req.status);
    });
  };

  ClientStore.prototype.updateClient = function(data) {
    var dataId, self, url;
    self = this;
    dataId = data.id;
    url = ajaxAPIURL + 'client/' + dataId + '/update';
    console.log(url);
    return $.ajax({
      url: url,
      method: 'put',
      data: data
    }).done(function(data, status) {
      console.log('AJAX method successful: updateClient');
      return self.trigger('clientStore_getClients');
    }).fail(function(req, error) {
      console.log('AJAX method failed');
      console.log(req.status);
      return self.trigger('clientStore_updateClient_error', req.status);
    });
  };

  return ClientStore;

})();

clientStore = new ClientStore;

clientStore.on('clientStore_createClient', function(client) {
  return this.createClient(client);
});

clientStore.on('clientStore_getClients', function() {
  return this.getClients();
});

clientStore.on('clientStore_updateClient', function(client) {
  return this.updateClient(client);
});