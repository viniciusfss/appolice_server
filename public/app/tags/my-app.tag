<my-app>
  <my-login if={page == 'loginPage'}></my-login>
  <my-forgot-pass if={page == 'forgotPassPage'}></my-forgot-pass>
  <my-register if={page == 'registerPage'}></my-register>
  <script>
    var self = this;

    this.on('mount', function() {
      RiotControl.trigger('router_go_login');
    });

    this.on('update', function() {
      console.log(this.page);
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
