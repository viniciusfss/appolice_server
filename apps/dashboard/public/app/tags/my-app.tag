<my-app>
  <my-login if={loginPage}/>
  <my-forgot-pass if={forgotPassPage}/>
  <my-register if={registerPage} />
  <script>
    self = this;
    function resetAll(myTag) {
      myTag.loginPage = false;
      myTag.forgotPassPage = false;
      myTag.registerPage = false;
    }

    this.on('mount', function() {
      switch (opts.pageToDisplay) {
        case 'loginPage':
          RiotControl.trigger('router_go_login');
          break;
        case 'forgotPassPage':
          RiotControl.trigger('router_go_forgotpass');
          break;
        case 'registerPage':
          RiotControl.trigger('router_go_register');
          break;
        default:
      }
    })

    RiotControl.on('router_go_login', function() {
      resetAll(self);
      self.update({loginPage: true});
    })

    RiotControl.on('router_go_forgotpass', function() {
      console.log('router_go_forgotpass');
      resetAll(self);
      self.update({forgotPassPage: true});
    })

    RiotControl.on('router_go_register', function() {
      console.log('router_go_register');
      resetAll(self);
      self.update({registerPage:true});
    })
  </script>
</my-app>
