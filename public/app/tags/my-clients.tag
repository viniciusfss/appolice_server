<my-clients>
  <div class="page animsition" style="animation-duration: 0.8s; opacity: 1;">
    <div class="page-header">
      <h1 class="page-title">Clientes</h1>
      <div class="page-header-actions">
        <button class="btn btn-info" data-toggle="modal" data-target="#createClient">
          <span class="fa fa-plus"></span> Novo Cliente</button>
      </div>
    </div>
    <div class="page-content container-fluid">
      <div each={client in clients} class="panel">
        <header class="panel-heading">
          <h3 class="panel-title">
            {client.name || client.email}
            <span if={client.active} class="badge">ativo</span>
            <span if={!client.active} class="badge">inativo</span>
            <span class="pull-right">
              <button class="btn btn-sm btn-warning" data-toggle="modal"
                      onclick="{editPanel}" data-target="#editPanel">
                <span class="wb-pencil"></span> Editar</button>
            </span>
            <span class="panel-desc">
              {client.id} 
            </span>
        </h3>
        </header>
        <div class="panel-body">
          <div if={client.policies.length > 0}>
            <p each={policy in client.policies}>{policy.title}</p>
          </div>
          <div if={client.policies.length == 0}>
            <p>Não há apólices para esse usuário.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div id="createClient" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <form>
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">Novo cliente</h4>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label for="idInput">CPF/CNPJ</label>
              <input class="form-control" type="text" id="idInput" name="idInput" 
                     placeholder="111.111.111-11" onkeyup="{removeNonNumbers}" required />
            </div>
            <div class="form-group">
              <label for="emailInput">Email</label>
              <input class="form-control" type="text" id="emailInput" name="emailInput" 
                     placeholder="ana.belle@foo.com.br" required />
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
            <button type="button" class="btn btn-primary" onclick="{createClient}" data-dismiss="modal">Salvar</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  
  <div id="editPanel" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <form>
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">Editar cliente</h4>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label for="emailEditInput">Email</label>
              <input class="form-control" type="text" id="emailEditInput" name="emailEditInput" 
                     placeholder="ana.belle@foo.com.br" value="{client.email}" required />
            </div>
            <div class="form-group">
              <rg-toggle toggle="{toggler}"></rg-toggle> <span class="pull-right">Desativar/Ativar</span>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default"
                    data-dismiss="modal">Cancelar</button>
            <button type="button" class="btn btn-primary"
                    onclick="{updateClient}" data-dismiss="modal">Editar</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  
  <script>
    this.mixin('rg.router');
    var self = this;
    this.clients = null;
    this.toggler = new RgToggle({
      checked: false,
      ontoggle: function (e) {
        self.client.active = this.checked;
        self.update();
      }
    });
    
    this.client = { id: null, email: null, active: null };
    
    removeNonNumbers(e) {
      this.idInput.value = this.idInput.value.replace(/\D+/g, '');
    }
    
    createClient() {
      console.log(self.idInput.value, self.emailInput.value);
      client = {
        id: self.idInput.value,
        email: self.emailInput.value
      }
      RiotControl.trigger('clientStore_createClient', client);
    }
    
    editPanel(event) {
      self.client.id = event.item.client.id;
      self.client.email = event.item.client.email;
      self.client.active = event.item.client.active;
      
      if (self.client.active !== self.toggler.checked) {
        self.toggler.toggle();
      };
      
      self.update();
    }    
    
    updateClient() {
      console.log(self.client);
      self.client.email = self.emailEditInput.value || self.client.email;
      RiotControl.trigger('clientStore_updateClient', self.client);
    }    
    
    RiotControl.on('clientStore_getClients_done', function(clients) {
      self.update({clients: clients});
    });
    
  </script>
</my-clients>