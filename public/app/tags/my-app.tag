<my-app>
  <my-login if={page == 'loginPage'}></my-login>
  <my-forgot-pass if={page == 'forgotPassPage'}></my-forgot-pass>
  <my-register if={page == 'registerPage'}></my-register>
  <my-dashboard if={page == 'dashboardPage'}></my-dashboard>
  <script>
    var self = this;

    this.on('mount', function() {
      if (localStorage.token === '' || localStorage.token === undefined) {
        RiotControl.trigger('router_go_login');
      } else {
        RiotControl.trigger('router_go_dashboard');
      }
    });

    this.on('update', function() {
      console.log(this.page);
    });

    RiotControl.on('router_go_dashboard', function() {
      self.update({page: 'dashboardPage'});
    });

    RiotControl.on('router_go_login', function() {
      self.update({page: 'loginPage'});
    });

    RiotControl.on('router_go_forgotpass', function() {
      self.update({page: 'forgotPassPage'});
    });

    RiotControl.on('router_go_register', function() {
      self.update({page: 'registerPage'});
    });

  </script>
</my-app>
