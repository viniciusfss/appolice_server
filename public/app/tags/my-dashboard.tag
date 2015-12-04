<my-dashboard class="site-menubar-unfold">
  <nav class="site-navbar navbar navbar-default navbar-fixed-top navbar-mega" role="navigation">
    <a href="#/" onclick="{goDashboard}">
      <div class="navbar-header">
        <div class="navbar-brand navbar-brand-center site-gridmenu-toggle" data-toggle="gridmenu">
          <img class="navbar-brand-logo" src="/img/appolice_logo.png" width="35" alt="appolice">
          <span class="navbar-brand-text"> Appolice</span>
        </div>
      </div>
    </a>
    <div class="navbar-container container-fluid">
      <ul class="nav navbar-toolbar">
        <li class="hidden-float" id="toggleMenubar">
          <a data-toggle="menubar" href="#" role="button">
            <i class="icon hamburger hamburger-arrow-left">
                <span class="sr-only">Toggle menubar</span>
                <span class="hamburger-bar"></span>
              </i>
          </a>
        </li>
      </ul>
      <ul class="nav navbar-toolbar navbar-right navbar-toolbar-right">
        <li class="dropdown">
          <a class="navbar-avatar dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false"
          data-animation="scale-up" role="button">
            <i class="icon wb-user" aria-hidden="true"></i>
            <span>USEREMAIL</span>
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

  <div class="site-menubar">
    <div class="site-menubar-body">
      <div>
        <div>
          <ul class="site-menu">
            <li class="site-menu-category">Geral</li>
            <li class="site-menu-item">
              <a class="animsition-link" href="">
                <i class="site-menu-icon wb-users" aria-hidden="true"></i>
                <span class="site-menu-title">Clientes</span>
              </a>
            </li>
            <li class="site-menu-item has-sub">
              <a href="javascript:void(0)">
                <i class="site-menu-icon wb-book" aria-hidden="true"></i>
                <span class="site-menu-title">Apólices</span>
                <span class="site-menu-arrow"></span>
              </a>
              <ul class="site-menu-sub">
                <li class="site-menu-item">
                  <a class="animsition-link" href="">
                    <span class="site-menu-title">Comuns</span>
                  </a>
                </li>
                <li class="site-menu-item">
                  <a class="animsition-link" href="">
                    <span class="site-menu-title">Veículos</span>
                  </a>
                </li>
              </ul>
            </li>
            <li class="site-menu-item">
              <a class="animsition-link" href="#">
                <i class="site-menu-icon wb-bookmark" aria-hidden="true"></i>
                <span class="site-menu-title">Sinistros</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>

  <div class="page animsition" style="animation-duration: 0.8s; opacity: 1;">
    <div class="page-header">
      <h1 class="page-title">DASHBOARD</h1>
      <div class="page-header-actions">
        PAGE ACTIONS HERE
      </div>
    </div>
    <div class="page-content container-fluid">
      <div class="panel">
        <header class="panel-heading">
          <h3 class="panel-title">
              DASHBOARD
            <span class="panel-desc">
              DESCRIPTION
            </span>
        </h3>
        </header>
        <div class="panel-body">
          CONTENT
        </div>
      </div>
    </div>
  </div>
</my-dashboard>
