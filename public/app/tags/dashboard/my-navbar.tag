<my-navbar>
  <nav class="site-navbar navbar navbar-default navbar-fixed-top navbar-mega" role="navigation">
    <a href="#/" onclick="{goDashboard}">
      <div class="navbar-header">
        <div class="navbar-brand navbar-brand-center">
          <img class="navbar-brand-logo" src="/img/appolice_logo.png" width="35" alt="appolice">
          <span class="navbar-brand-text">Appolice</span>
        </div>
      </div>
    </a>
    <div class="navbar-container container-fluid">
      <ul class="nav navbar-toolbar">
        <li class="hidden-float" id="toggleMenubar">
          <!--<a data-toggle="menubar" href="#" role="button">
            <i class="icon hamburger hamburger-arrow-left">
                <span class="sr-only">Toggle menubar</span>
                <span class="hamburger-bar"></span>
              </i>
          </a>-->
        </li>
      </ul>
      <ul class="nav navbar-toolbar navbar-right navbar-toolbar-right">
        <li><a href="#" role="menuitem"><i class="icon wb-power" aria-hidden="true"></i></a></li>
      </ul>
    </div>
  </nav>

  <script>
    this.mixin('rg.router');

    self = this;

    this.on('mount', function() {
      RiotControl.trigger('userStore_get_account_details', function(error, data) {
        if (error) {
          console.log("ERROR!");
        } else {
          self.update({userEmail: data.user.email || 'Nenhum email'});
        }
      });
    });

    goDashboard () {
      this.router.go('dashboard');
    }

  </script>
</my-navbar>
