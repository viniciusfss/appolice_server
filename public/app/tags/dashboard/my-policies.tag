<my-policies>
  <div class="page animsition" style="animation-duration: 0.8s; opacity: 1;">
    <div class="page-header">
      <h1 class="page-title">Apólices Comuns</h1>
      <div class="page-header-actions">
        <button class="btn btn-info" data-toggle="modal" data-target="#createPolicy">
          <span class="fa fa-plus"></span> Nova Apólice</button>
      </div>
    </div>
    <div class="page-content container-fluid">
      <div each="{policy in policies}" class="panel">
        <header class="panel-heading">
          <h3 class="panel-title">
              Novidades
            <span class="panel-desc">
              DESCRIPTION
            </span>
        </h3>
        </header>
        <div class="panel-body">
          CONTENT
        </div>
      </div>
      <div if="{policies.length == 0}" class="panel text-center">
        <header class="panel-heading">
          <h3 class="panel-title">Você não possui apólices comuns cadastradas.</h3>
        </header>
        <div class="panel-body">Para começar, selecione Nova Apólice acima.</div>
      </div>
    </div>
  </div>
  
  <div id="createPolicy" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <form>
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">Nova apólice</h4>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label for="titleInput">Título</label>
              <input class="form-control" type="text" id="titleInput" name="titleInput" 
                     placeholder="Apólice de seguro" required />
            </div>
            <div class="form-group">
              <label for="subTitleInput">Subtítulo</label>
              <input class="form-control" type="text" id="subTitleInput" name="subTitleInput" 
                     placeholder="Apólice 389" required />
            </div>
            <div class="form-group">
              <label for="selectClientInput">Cliente</label>
              <select class="form-control" id="selectClientInput" required>
                <option>Escolha da lista abaixo</option>
                <option each="{client in clients}">{client.id}: {client.email}</option>
              </select>
            </div>
            <div class="form-group">
              <label for="fileInput">Arquivo</label>
              <input class="form-control" type="file" id="fileInput" name="fileInput" />
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
  
  <script>
    this.mixin('rg.router');
    var self = this;    
    this.policies = [];
    this.clients = []
    
    RiotControl.on('policyStore_getPolicies_done', function(data) {
      policies = []
      for (policy in data.policies) {
        pol = {policy: policy, id: data.id, email: data.email}
        policies.push(pol);
      }
      self.update({policies: policies, clients: data});
    });
  </script>
</my-policies>
