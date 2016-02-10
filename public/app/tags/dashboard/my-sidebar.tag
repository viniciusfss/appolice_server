<my-sidebar>
  <div class="site-menubar">
    <div class="site-menubar-body">
      <div>
        <ul class="site-menu">
          <li class="site-menu-category">Geral</li>
          <li class="site-menu-item">
            <a class="" href="#" onclick="{goClients}">
              <i class="site-menu-icon wb-users" aria-hidden="true"></i>
              <span class="site-menu-title">Clientes</span>
            </a>
          </li>
          <li class="site-menu-item has-sub">
            <a class="" href="#" onclick="{goPolicies}">
              <i class="site-menu-icon wb-book" aria-hidden="true"></i>
              <span class="site-menu-title">Apólices Comuns</span>
            </a>
          </li>
          <li class="site-menu-item">
            <a class="" href="#" onclick="{goCarPolicies}">
              <i class="site-menu-icon wb-hammer" aria-hidden="true"></i>
              <span class="site-menu-title">Apólices de Veículos</span>
            </a>
          </li>
          <li class="site-menu-item">
            <a class="" href="#">
              <i class="site-menu-icon wb-bookmark" aria-hidden="true"></i>
              <span class="site-menu-title">Sinistros</span>
            </a>
          </li>
          <li class="site-menu-category">Mensagens</li>
          <li class="site-menu-item" each={client in clients}>
            <a class="" href="#" onclick="{goClientMessages}">
              <i class="site-menu-icon wb-chat" aria-hidden="true"></i>
              <span class="site-menu-title">{client.name || client.id}</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>

  <script>
    this.mixin('rg.router');
    var self = this;
    this.clients = null;

    goClients() {
      rg.router.go("clients");
    };

    goPolicies() {
      rg.router.go("policies");
    }

    goCarPolicies() {
      rg.router.go("car-policies");
    };

    goClientMessages(e) {
      rg.router.go("messages", e.item.client);
    };

    RiotControl.on('clientStore_getClients_done', function (clients) {
      self.update({clients: clients});
    })

  </script>
</my-sidebar>
