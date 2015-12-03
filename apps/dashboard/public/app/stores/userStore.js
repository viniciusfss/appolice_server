// Generated by CoffeeScript 1.10.0
'use strict';
var UserStore, userStore;

UserStore = (function() {
  function UserStore(token) {
    this.token = token;
    console.log('Creating UserStore');
    riot.observable(this);
  }

  return UserStore;

})();

userStore = new UserStore(localStorage.token);

userStore.on('userStore_check_token', function() {
  console.log('userStore_check_token: ' + this.token);
  if (this.token == null) {
    return this.trigger('');
  }
});

userStore.on('userStore_do_login', function() {
  return console.log('userStore_do_login');
});

userStore.on('userStore_do_register', function(data) {
  console.log('userStore_do_register');
  return $.ajax({
    url: ajaxAPIURL + 'account/create',
    method: 'put',
    data: data
  }).done(function(data, status) {
    console.log('AJAX method successful!');
    return RiotControl.trigger('router_go_login', 'just_created_account');
  }).fail(function(req, error) {
    console.log('AJAX method failed!');
    return console.log(req);
  });
});
