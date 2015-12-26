// Generated by CoffeeScript 1.10.0
'use strict';
var UserStore, userStore;

UserStore = (function() {
  function UserStore() {
    console.log('Creating UserStore');
    riot.observable(this);
  }

  return UserStore;

})();

userStore = new UserStore;

if (localStorage.token) {
  $.ajaxSetup({
    headers: {
      'x-token': localStorage.token
    }
  });
}

userStore.on('userStore_check_token', function() {
  console.log('userStore_check_token: ' + localStorage.token);
  if (localStorage.token == null) {
    return rg.router.go('login');
  } else {
    console.log('userStore_check_token: Setting AJAX.');
    $.ajaxSetup({
      headers: {
        'x-token': localStorage.token
      }
    });
    return rg.router.go('dashboard');
  }
});

userStore.on('userStore_get_account_details', function(cb) {
  return $.ajax({
    url: ajaxAPIURL + 'account/',
    method: 'get'
  }).done(function(data, status) {
    console.log('AJAX method successful!');
    return cb(void 0, data);
  }).fail(function(req, error) {
    console.log('AJAX method failed!');
    return console.log(req);
  });
});

userStore.on('userStore_do_login', function(data) {
  console.log('userStore_do_login');
  return $.ajax({
    url: ajaxAPIURL + 'account/login',
    method: 'put',
    data: data
  }).done(function(data, status) {
    console.log('AJAX method successful!');
    localStorage.token = data.token;
    return RiotControl.trigger('userStore_check_token');
  }).fail(function(req, error) {
    console.log('AJAX method failed!');
    return console.log(req);
  });
});

userStore.on('userStore_do_register', function(data) {
  console.log('userStore_do_register');
  return $.ajax({
    url: ajaxAPIURL + 'account/create',
    method: 'put',
    data: data
  }).done(function(data, status) {
    console.log('AJAX method successful!');
    return rg.router.go('login', {
      justCreatedAccount: true
    });
  }).fail(function(req, error) {
    console.log('AJAX method failed!');
    return console.log(req);
  });
});
