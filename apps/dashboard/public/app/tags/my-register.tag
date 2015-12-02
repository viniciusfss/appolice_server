<my-register class="page-login layout-full page-dark site-menubar-fold">
  <div class="page vertical-align text-center" data-animsition-in="fade-in"
  data-animsition-out="fade-out">>
    <div class="page-content vertical-align-middle">
      <div class="brand">
        <img class="brand-img" src="/img/appolice_logo.png" width="150" alt="...">
        <h2 class="brand-text">Appolice</h2>
      </div>
      <p>Acesse o painel administrativo</p>

      <form onsubmit={doRegister}>
        <div class="form-group">
          <input type="numbers" class="form-control" placeholder="CPF/CNPJ (Apenas Números)" name="login" required>
        </div>

        <div class="form-group">
          <input type="email" class="form-control" placeholder="Email" name="email" required>
        </div>

        <div class="form-group">
          <input type="password" class="form-control" placeholder="Senha" name="password" onkeyup={validateForm} required>
        </div>

        <div class="form-group">
          <input type="password" class="form-control" placeholder="Confirmação de Senha" name="password2" onkeyup={validateForm} required>
        </div>

        <div class="form-group clearfix">
          <div class="checkbox-custom checkbox-inline checkbox-primary pull-left">
            <input type="checkbox" name="checkme" onchange={validateForm}>
            <label for="inputCheckbox">Aceito o Contrato para Corretores e a Política de Privacidade para fazer uso do sistema.</label>
          </div>
        </div>

        <button disabled={disableBtn} type="submit" class="btn btn-primary btn-block">Cadastrar</button>
      </form>

      <p>Já tem uma conta? Acesse o painel fazendo o <a href="#/" onclick="{goToLogin}">Login</a></p>

      <footer class="page-copyright page-copyright-inverse">
        <p>Desenvolvido por <a href="http://criar.me">criar.me</a></p>
        <p>© 2015. Todos os direitos reservados.</p>
      </footer>
    </div>
  </div>

  <script>
    this.disableBtn = true;
    
    this.on('mount', function() {
        console.log('AODFUYISODUFYISUDYF');
    })

    goToLogin(e) {
      RiotControl.trigger('router_go_login');
    }

    validateForm(e) {
      if((this.password.value == this.password2.value)
          && (this.login.value != '')
          && (this.email.value != '')
          && (this.password.value != '')
          && (this.password2.value != '')
          && (this.checkme.checked)) {
        this.disableBtn = false;
      } else {
        this.disableBtn = true;
      }
    }

    doRegister(e) {
      vals = {
        _id: this.login.value,
        email: this.email.value,
        password: this.password.value
      }

      RiotControl.trigger('userStore_do_register', vals);
    }
  </script>
</my-register>
