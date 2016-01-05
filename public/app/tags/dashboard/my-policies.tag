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
      <div if="{policies.length > 0}" class="panel">
          <table class="table table-hover">
            <thead>
              <tr>
                <th></th>
                <th>Título</th>
                <th>Cliente</th>
                <th>Valor</th>
                <th>Criada em</th>
                <th>Atualizada em</th>
              </tr>
            </thead>
            <tbody>
              <tr each="{policy in policies}">
                <th><button class="btn btn-xs btn-warning" data-toggle="modal"
                            data-target="#editPolicy" onclick="{fillEditPolicy}">
                    <span class="wb-pencil"></span> Editar</button></th>
                <th>{policy.title}</th>
                <th>{policy.email}</th>
                <th>{"R$ " + (policy.value || 0.00)}</th>
                <th>00/00/0000</th>
                <th>01/01/0001</th>
              </tr>
            </tbody>
        </table>
      </div>
      <div if="{policies.length <= 0}" class="panel text-center">
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
              <label for="createTitleInput">Título</label>
              <input class="form-control" type="text" id="createTitleInput" name="createTitleInput"
                     placeholder="Apólice de seguro" required />
            </div>
            <div class="form-group">
              <label for="createSubtitleInput">Subtítulo</label>
              <input class="form-control" type="text" id="createSubtitleInput" name="createSubtitleInput"
                     placeholder="Apólice 389" required />
            </div>
            <div class="form-group">
              <label for="createValueInput">Valor da Apolice</label>
              <input class="form-control" type="number" id="createValueInput" name="createValueInput"
                placeholder="R$ 1000,00" required />
            </div>
            <div class="form-group">
              <label for="createClientInput">Cliente</label>
              <select class="form-control" id="createClientInput" required>
                <option>Escolha da lista abaixo</option>
                <option each="{client in clients}" value="{client.id}">{client.email}</option>
              </select>
            </div>
            <div class="form-group">
              <label for="createFileInput">Arquivo</label>
              <input class="form-control" type="file" id="createFileInput" name="fileInput" />
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
            <button type="button" class="btn btn-primary" onclick="{createPolicy}" data-dismiss="modal">Salvar</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <div id="editPolicy" class="modal fade" tabindex="-1" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <form>
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title">Editar apólice</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label for="editTitleInput">Título</label>
                <input class="form-control" type="text" id="editTitleInput" name="editTitleInput"
                       value="{policy.title}" required />
              </div>
              <div class="form-group">
                <label for="editSubTitleInput">Subtítulo</label>
                <input class="form-control" type="text" id="editSubTitleInput" name="editSubTitleInput"
                       value="{policy.subtitle}" required />
              </div>
              <div class="form-group">
                <label for="editValueInput">Valor da Apolice</label>
                <input class="form-control" type="number" id="editValueInput" name="editValueInput"
                       value="{policy.value}" required />
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
              <button type="button" class="btn btn-primary" onclick="{editPolicy}" data-dismiss="modal">Salvar</button>
            </div>
          </form>
        </div>
      </div>
    </div>

  <!-- TODO: HANDLE FILE UPLOADS, CREATED/EDITED AT -->
  <script>
    this.mixin('rg.router');
    var self = this;    
    this.policies = [];
    this.clients = [];
    this.policy = {clientId: null, title: null, subtitle: null, value: null, file: null};

    createPolicy(e) {
      policy = {
        clientId: this.createClientInput.value,
        title: this.createTitleInput.value,
        subtitle: this.createSubtitleInput.value,
        value: this.createValueInput.value,
      };
      RiotControl.trigger('policyStore_addPolicyToClient', policy);
    }

    fillEditPolicy(e) {
        policy = {
            _id: e.item.policy._id,
            clientId: e.item.policy.clientId,
            title: e.item.policy.title,
            subtitle: e.item.policy.subtitle,
            value: e.item.policy.value,
        };

        self.update({policy: policy});
    }

    editPolicy(e) {
        policy = {
            _id: self.policy._id,
            clientId: self.policy.clientId,
            title: this.editTitleInput.value,
            subtitle: this.editSubTitleInput.value,
            value: this.editValueInput.value,
        };
        RiotControl.trigger('policyStore_editPolicy', policy);
    }

    RiotControl.on('policyStore_getPolicies_done', function(data) {
      var policies = [];
      for (var it in data) {
        for (var itr in data[it].policies) {
          policy = data[it].policies[itr];
          var pol = {
            title: policy.title,
            subtitle: policy.subtitle,
            value: policy.value,
            clientId: data[it].id,
            email: data[it].email,
            _id: policy._id,
          }
          policies.push(pol);
        }
      }
      self.update({policies: policies, clients: data});
    });
  </script>
</my-policies>
