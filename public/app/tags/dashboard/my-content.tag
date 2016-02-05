<my-content>
  <div class="page animsition" style="animation-duration: 0.8s; opacity: 1;">
    <div class="page-header">
      <h1 class="page-title">Minha Página</h1>
      <div class="page-header-actions">
        <button class="btn btn-info" data-toggle="modal" data-target="#editProfile">Editar perfil</button>
      </div>
    </div>
    <div class="page-content container-fluid text-center">
      <div class="panel">
        <header class="panel-heading">
          <h3 class="panel-title">
            <br>
            <img src="{user.imgPath || '/img/appolice_logo.png'}" class="img-rounded" width="100px" height="100px" alt="Minha Foto"></img>
            <br><br>
            <p>{user.name || 'Nome do corretor'}</p>
            <span class="panel-desc">
               {user.email || "Não há email especificado"}
            </span>
        </h3>
        </header>
        <div class="panel-body">
          <p>{user.location || "Não especificado"}</p>
          <p>{user.phone || "Não foi especificado um telefone"}</p>
          <hr>
          <div class="text-center">
            <img if="{user.kindOfPolicies.carPolicy}" src="/img/symbols/car.png" />
            <img if="{user.kindOfPolicies.devicePolicy}" src="/img/symbols/devices.png" />
            <img if="{user.kindOfPolicies.lifePolicy}" src="/img/symbols/life.png" />
            <img if="{user.kindOfPolicies.personalPolicy}" src="/img/symbols/personal.png" />
            <img if="{user.kindOfPolicies.propertyPolicy}" src="/img/symbols/property.png" />
            <img if="{user.kindOfPolicies.travelPolicy}" src="/img/symbols/travel.png" />
            <img if="{user.kindOfPolicies.workPolicy}" src="/img/symbols/work.png" />
          </div>
        </div>
      </div>
    </div>

    <div id="editProfile" class="modal fade" tabindex="-1" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <form id="formData">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title">Editar Perfil</h4>
              </div>
              <div class="modal-body">
                <div class="form-group">
                  <label for="nameInput">Nome Completo</label>
                  <input class="form-control" type="text" id="nameInput" name="nameInput"
                         placeholder="Annabelle Miranda" value="{user.name}" required />
                </div>
                <div class="form-group">
                  <label for="emailInput">Email</label>
                  <input class="form-control" type="text" id="emailInput" name="emailInput"
                         placeholder="ana.belle@foo.com.br" value="{user.email}" required />
                </div>
                <div class="form-group">
                  <label for="phoneInput">(DDD) Telefone</label>
                  <input class="form-control" type="phone" id="phoneInput" name="phoneInput"
                         placeholder="(21) 3222-2222" value="{user.phone}" required />
                </div>
                <div class="form-group">
                  <label for="locationInput">Cidade, Estado</label>
                  <input class="form-control" type="text" id="locationInput" name="locationInput"
                         placeholder="Rio de Janeiro, RJ" value="{user.location}" required />
                </div>
                <div class="form-group">
                  <label for="imgInput">Imagem do Perfil</label>
                  <input class="form-control" type="file" id="imgInput" name="imgInput" required />
                </div>
                <div class="form-group"><hr>
                  <h5 for="imgInput">Meus tipos de seguro</h5><hr>
                  <span>Seguro de Automóvel</span> <rg-toggle class="pull-right" toggle="{carPolicy}"></rg-toggle><hr>
                  <span>Seguro de Equipamentos Portateis</span> <rg-toggle class="pull-right" toggle="{devicePolicy}"></rg-toggle><hr>
                  <span>Seguro de Viagem</span> <rg-toggle class="pull-right" toggle="{travelPolicy}"></rg-toggle><hr>
                  <span>Seguro de Vida</span> <rg-toggle class="pull-right" toggle="{lifePolicy}"></rg-toggle><hr>
                  <span>Seguro de Residência</span> <rg-toggle class="pull-right" toggle="{propertyPolicy}"></rg-toggle><hr>
                  <span>Seguro de Responsabilidade Civil e Profissional</span> <rg-toggle class="pull-right" toggle="{workPolicy}"></rg-toggle><hr>
                  <span>Seguro de Acidentes Pessoais</span> <rg-toggle class="pull-right" toggle="{personalPolicy}"></rg-toggle><hr>
                </div>

              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" onclick="{editProfile}" data-dismiss="modal">Salvar</button>
              </div>
            </form>
          </div>
        </div>
      </div>

  </div>

  <script>
    this.mixin('rg.router');
    var self = this;
    this.user = {name: null, email: null, imgPath: null, services: null, location: null, phone: null,
        kindOfPolicies: {carPolicy: null, devicePolicy: null, travelPolicy: null, lifePolicy: null,
                         propertyPolicy: null, workPolicy: null, personalPolicy: null}};

    this.carPolicy = new RgToggle({
      checked: false,
      ontoggle: function (e) {
        self.user.kindOfPolicies.carPolicy = this.checked;
        self.update();
      }
    });

    this.devicePolicy = new RgToggle({
      checked: false,
      ontoggle: function (e) {
        self.user.kindOfPolicies.devicePolicy = this.checked;
        self.update();
      }
    });

    this.travelPolicy = new RgToggle({
      checked: false,
      ontoggle: function (e) {
        self.user.kindOfPolicies.travelPolicy = this.checked;
        self.update();
      }
    });

    this.lifePolicy = new RgToggle({
      checked: false,
      ontoggle: function (e) {
        self.user.kindOfPolicies.lifePolicy = this.checked;
        self.update();
      }
    });

    this.propertyPolicy = new RgToggle({
      checked: false,
      ontoggle: function (e) {
        self.user.kindOfPolicies.propertyPolicy = this.checked;
        self.update();
      }
    });

    this.workPolicy = new RgToggle({
      checked: false,
      ontoggle: function (e) {
        self.user.kindOfPolicies.workPolicy = this.checked;
        self.update();
      }
    });

    this.personalPolicy = new RgToggle({
      checked: false,
      ontoggle: function (e) {
        self.user.kindOfPolicies.personalPolicy = this.checked;
        self.update();
      }
    });

    editProfile() {
        var data = new FormData();
        data.append('file', self.imgInput.files[0]);
        data.append('name', self.nameInput.value);
        data.append('email', self.emailInput.value);
        data.append('location', self.locationInput.value);
        data.append('phone', self.phoneInput.value);
        data.append('personalPolicy', self.user.kindOfPolicies.personalPolicy);
        data.append('propertyPolicy', self.user.kindOfPolicies.propertyPolicy);
        data.append('lifePolicy', self.user.kindOfPolicies.lifePolicy);
        data.append('travelPolicy', self.user.kindOfPolicies.travelPolicy);
        data.append('devicePolicy', self.user.kindOfPolicies.devicePolicy);
        data.append('workPolicy', self.user.kindOfPolicies.workPolicy);
        data.append('carPolicy', self.user.kindOfPolicies.carPolicy);
        console.log(self.user.kindOfPolicies.workPolicy);
        if (self.imgInput.files[0]) data.append('filename', self.imgInput.files[0].name);

        RiotControl.trigger('userStore_update_profile', data);
    }

    RiotControl.on('userStore_get_account_details_done', function(data) {
        self.user.name = data.user.name;
        self.user.email = data.user.email;
        self.user.imgPath = data.user.imgPath;
        self.user.services = data.user.services;
        self.user.location = data.user.location;
        self.user.kindOfPolicies = data.user.kindOfPolicies;
        self.user.phone = data.user.phone;
        if (data.user.kindOfPolicies.personalPolicy) self.personalPolicy.checked = true;
        if (data.user.kindOfPolicies.propertyPolicy) self.propertyPolicy.checked = true;
        if (data.user.kindOfPolicies.lifePolicy) self.lifePolicy.checked = true;
        if (data.user.kindOfPolicies.travelPolicy) self.travelPolicy.checked = true;
        if (data.user.kindOfPolicies.devicePolicy) self.devicePolicy.checked = true;
        if (data.user.kindOfPolicies.workPolicy) self.workPolicy.checked = true;
        if (data.user.kindOfPolicies.carPolicy) self.carPolicy.checked = true;

        self.update();
    });
  </script>
</my-content>


