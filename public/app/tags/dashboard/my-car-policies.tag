<my-car-policies>
  <div class="page animsition" style="animation-duration: 0.8s; opacity: 1;">
    <div class="page-header">
      <h1 class="page-title">Apólices de Veículos</h1>
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
              <th>
                <button class="btn btn-xs btn-warning" data-toggle="modal" data-target="#editPolicy" onclick="{fillEditPolicy}">
                  <span class="wb-pencil"></span> Editar</button>
              </th>
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
          <h3 class="panel-title">Você não possui apólices de veículos cadastradas.</h3>
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
              <label for="createClientInput">Cliente</label>
              <select class="form-control" id="createClientInput" required>
                <option>Escolha da lista abaixo</option>
                <option each="{client in clients}" value="{client.id}">{client.email}</option>
              </select>
            </div>
            <div class="form-group">
              <label for="createTitleInput">Título</label>
              <input class="form-control" type="text" id="createTitleInput" name="createTitleInput" placeholder="Apólice de veículo" required
              />
            </div>
            <div class="form-group">
              <label for="createSubtitleInput">Subtítulo</label>
              <input class="form-control" type="text" id="createSubtitleInput" name="createSubtitleInput" placeholder="Apólice 766" required
              />
            </div>
            <div class="form-group">
              <label for="createValueInput">Valor da Apolice</label>
              <input class="form-control" type="number" id="createValueInput" name="createValueInput" placeholder="R$ 1000,00" required
              />
            </div>
            <div class="form-group">
              <label for="createModelInput">Modelo</label>
              <input class="form-control" type="text" id="createModelInput" name="createModelInput" placeholder="Uno" required />
            </div>
            <div class="form-group">
              <label for="createBrandInput">Marca</label>
              <input class="form-control" type="text" id="createBrandInput" name="createBrandInput" placeholder="Fiat" required />
            </div>
            <div class="form-group">
              <label for="createPlateInput">Placa</label>
              <input class="form-control" type="text" id="createPlateInput" name="createPlateInput" placeholder="KGB 1234" required />
            </div>
            <div class="form-group">
              <label for="createProductionYearInput">Ano de Fabricação</label>
              <input class="form-control" type="number" id="createProductionYearInput" name="createProductionYearInput" placeholder="2012"
              required />
            </div>
            <div class="form-group">
              <label for="createModelYearInput">Ano do Modelo</label>
              <input class="form-control" type="number" id="createModelYearInput" name="createModelYearInput" placeholder="2013" required
              />
            </div>
            <div class="form-group">
              <label for="createColourInput">Cor</label>
              <input class="form-control" type="text" id="createColourInput" name="createColourInput" placeholder="Preto" required />
            </div>
            <div class="form-group">
              <label for="createDriverInput">Motorista</label>
              <input class="form-control" type="text" id="createDriverInput" name="createDriverInput" placeholder="Anabelle Vaz" required
              />
            </div>
            <!--<div class="form-group">
              <label for="createFileInput">Arquivo</label>
              <input class="form-control" type="file" id="createFileInput" name="fileInput" />
            </div>-->
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
              <input class="form-control" type="text" id="editTitleInput" name="editTitleInput" value="{policy.title}" required />
            </div>
            <div class="form-group">
              <label for="editSubTitleInput">Subtítulo</label>
              <input class="form-control" type="text" id="editSubTitleInput" name="editSubTitleInput" value="{policy.subtitle}" required
              />
            </div>
            <div class="form-group">
              <label for="editValueInput">Valor da Apolice</label>
              <input class="form-control" type="number" id="editValueInput" name="editValueInput" value="{policy.value}" required />
            </div>
            <div class="form-group">
              <label for="editModelInput">Modelo</label>
              <input class="form-control" type="text" id="editModelInput" name="editModelInput" value="{policy.model}" required />
            </div>
            <div class="form-group">
              <label for="editBrandInput">Marca</label>
              <input class="form-control" type="text" id="editBrandInput" name="editBrandInput" value="{policy.brand}" required />
            </div>
            <div class="form-group">
              <label for="editPlateInput">Placa</label>
              <input class="form-control" type="text" id="editPlateInput" name="editPlateInput" value="{policy.plate}" required />
            </div>
            <div class="form-group">
              <label for="editProductionYearInput">Ano de Fabricação</label>
              <input class="form-control" type="number" id="editProductionYearInput" name="editProductionYearInput" value="{policy.productionYear}"
              required />
            </div>
            <div class="form-group">
              <label for="editModelYearInput">Ano do Modelo</label>
              <input class="form-control" type="number" id="editModelYearInput" name="editModelYearInput" value="{policy.modelYear}" required
              />
            </div>
            <div class="form-group">
              <label for="editColourInput">Cor</label>
              <input class="form-control" type="text" id="editColourInput" name="editColourInput" value="{policy.colour}" required />
            </div>
            <div class="form-group">
              <label for="editDriverInput">Motorista</label>
              <input class="form-control" type="text" id="editDriverInput" name="editDriverInput" value="{policy.driver}" required
              />
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
        brand: this.createBrandInput.value,
        model: this.createModelInput.value,
        plate: this.createPlateInput.value,
        productionYear: this.createProductionYearInput.value,
        modelYear: this.createModelYearInput.value,
        colour: this.createColourInput.value,
        driver: this.createDriverInput.value,
      };
      RiotControl.trigger('policyStore_addCarPolicyToClient', policy);
    }

    fillEditPolicy(e) {
        policy = {
            _id: e.item.policy._id,
            clientId: e.item.policy.clientId,
            title: e.item.policy.title,
            subtitle: e.item.policy.subtitle,
            value: e.item.policy.value,
            brand: e.item.policy.brand,
            model: e.item.policy.model,
            plate: e.item.policy.plate,
            productionYear: e.item.policy.productionYear,
            modelYear: e.item.policy.modelYear,
            colour: e.item.policy.colour,
            driver: e.item.policy.driver,
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
            brand: this.editBrandInput.value,
            model: this.editModelInput.value,
            plate: this.editPlateInput.value,
            productionYear: this.editProductionYearInput.value,
            modelYear: this.editModelYearInput.value,
            colour: this.editColourInput.value,
            driver: this.editDriverInput.value,
        };
        RiotControl.trigger('policyStore_editCarPolicy', policy);
    }

    RiotControl.on('policyStore_getCarPolicies_done', function(data) {
      var policies = [];
      for (var it in data) {
        for (var itr in data[it].policies) {
          policy = data[it].policies[itr];
          var pol = {
            title: policy.title,
            subtitle: policy.subtitle,
            value: policy.value,
            brand: policy.brand,
            model: policy.model,
            plate: policy.plate,
            productionYear: policy.productionYear,
            modelYear: policy.modelYear,
            colour: policy.colour,
            driver: policy.driver,
            clientId: data[it].id,
            email: data[it].email,
            _id: policy._id,
          }
          console.log(pol);
          policies.push(pol);
        }
      }
      self.update({policies: policies, clients: data});
    });
  </script>
</my-car-policies>