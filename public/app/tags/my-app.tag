<my-app>
  <my-login if={page == 'loginPage'}></my-login>
  <my-forgot-pass if={page == 'forgotPassPage'}></my-forgot-pass>
  <my-register if={page == 'registerPage'}></my-register>
  <my-dashboard if={page == 'dashboardPage'}></my-dashboard>
  <script>
    this.mixin('rg.router');

    var self = this;

    this.on('mount', function() {
      if (localStorage.token === '' || localStorage.token === undefined) {
        self.router.go('login');
      } else {
        self.router.go('dashboard');
        RiotControl.trigger('clientStore_getClients');
      }
    });

    self.router.on('go', function(current, previous) {
      if (current.name === 'login') {
        self.update({page: 'loginPage'});
      }
    });

    self.router.on('go', function(current, previous) {
      if (current.name === 'dashboard') {
        self.update({page: 'dashboardPage'});
      }
    });

    self.router.on('go', function(current, previous) {
      if (current.name === 'login-forgot') {
        self.update({page: 'forgotPassPage'});
      }
    });

    self.router.on('go', function(current, previous) {
      if (current.name === 'register') {
        self.update({page: 'registerPage'});
      }
    });
  </script>
</my-app>
