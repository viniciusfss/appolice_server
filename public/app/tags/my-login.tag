<my-login class="page-login layout-full page-dark site-menubar-fold">
  <div class="page vertical-align text-center" data-animation-in="fade-in"
  data-animsition-out="fade-out">>
    <div class="page-content vertical-align-middle">
      <div class="brand">
        <img class="brand-img" src="/img/appolice_logo.png" width="150" alt="...">
        <h2 class="brand-text">Appolice</h2>
      </div>
      <p>Acesse o painel administrativo</p>

      <p if={justCreatedAccount} class="well well-sm well-success" role="alert">
        <strong>Sucesso!</strong> Conta criada. Por favor, faça o login.
      </p>

      <form onsubmit={doLogin}>
        <div class="form-group">
          <input type="numbers" class="form-control" placeholder="CPF/CNPJ (Apenas Números)" onkeyup={removeNonNumbers} name="login" required>
        </div>

        <div class="form-group">
          <input type="password" class="form-control" placeholder="Senha" name="password" required>
        </div>

        <div class="form-group clearfix">
          <div class="checkbox-custom checkbox-inline checkbox-primary pull-left">
            <input type="checkbox" id="id_remember" name="remember">
            <label for="inputCheckbox">Lembrar-me</label>
          </div>
          <a href='#!/login/forgot' class="pull-right" onclick={goToForgotPass}>Esqueceu a senha?</a>
        </div>

        <button type="submit" class="btn btn-primary btn-block">Entrar</button>
      </form>

      <p>Não tem uma conta? <a href="#!/register" onclick={goToRegister}>Registre-se</a>

      <footer class="page-copyright page-copyright-inverse">
        <p>Desenvolvido por <a href="http://criar.me">criar.me</a></p>
        <p>© 2015. Todos os direitos reservados.</p>
      </footer>
    </div>
  </div>

  <script>
    this.mixin('rg.router');
    var self = this;
    this.on('mount', function() {
    });

    self.router.on('go', function(current, previous) {
      if (current.name === 'login') {
        self.update({justCreatedAccount: current.params.justCreatedAccount});
      }
    });

    removeNonNumbers(e) {
      this.login.value = this.login.value.replace(/\D+/g, '');
    }

    doLogin(e) {
      vals = {
        id: this.login.value,
        password: this.password.value
      }
      RiotControl.trigger('userStore_do_login', vals);
    }

    goToForgotPass(e) {
      self.router.go('login-forgot');
    }

    goToRegister(e) {
      self.router.go('register');
    }
  </script>
</my-login>
