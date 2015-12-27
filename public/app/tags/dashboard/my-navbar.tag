<my-navbar>
  <nav class="site-navbar navbar navbar-default navbar-fixed-top navbar-mega" role="navigation">
    <a href="#/" onclick="{goDashboard}">
      <div class="navbar-header">
        <div class="navbar-brand navbar-brand-center site-gridmenu-toggle" data-toggle="gridmenu">
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
        <li class="dropdown">
          <a class="navbar-avatar dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false"
          data-animation="scale-up" role="button">
            <i class="icon wb-user" aria-hidden="true"></i>
            <span>{userEmail}</span>
          </a>
          <ul class="dropdown-menu" role="menu">
            <li role="presentation">
              <a href="" role="menuitem"><i class="icon wb-user" aria-hidden="true"></i> Editar Perfil</a>
            </li>
            <li class="divider" role="presentation"></li>
            <li role="presentation">
              <a href="" role="menuitem"><i class="icon wb-power" aria-hidden="true"></i> Sair</a>
            </li>
          </ul>
        </li>
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
          // self.update({userEmail: 'No email'});
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
