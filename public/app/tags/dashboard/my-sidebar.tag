<my-sidebar>
  <div class="site-menubar">
    <div class="site-menubar-body">
      <div>
        <ul class="site-menu">
          <li class="site-menu-category">Geral</li>
          <li class="site-menu-item">
            <a class="animsition-link" href="#" onclick="{goClients}">
              <i class="site-menu-icon wb-users" aria-hidden="true"></i>
              <span class="site-menu-title">Clientes</span>
            </a>
          </li>
          <li class="site-menu-item has-sub">
            <a class="animsition-link" href="#">
              <i class="site-menu-icon wb-book" aria-hidden="true"></i>
              <span class="site-menu-title">Apólices Comuns</span>
            </a>
          </li>
          <li class="site-menu-item">
            <a class="animsition-link" href="#">
              <i class="site-menu-icon wb-hammer" aria-hidden="true"></i>
              <span class="site-menu-title">Apólices de Veículos</span>
            </a>
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
  
  <script>
    this.mixin('rg.router');
    var self = this;
    
    goClients() {
      rg.router.go("clients");
    };
  </script>
</my-sidebar>
