<my-login class="page-login layout-full page-dark site-menubar-fold">
  <div class="page vertical-align text-center" data-animation-in="fade-in"
  data-animsition-out="fade-out">>
    <div class="page-content vertical-align-middle">
      <div class="brand">
        <img class="brand-img" src="/img/appolice_logo.png" width="150" alt="...">
        <h2 class="brand-text">Appolice</h2>
      </div>
      <p>Acesse o painel administrativo</p>

      <form onsubmit="{doLogin}" method="post">
        <div class="form-group">
          <input type="numbers" class="form-control" placeholder="CPF/CNPJ (Apenas Números)" name="login" required>
        </div>

        <div class="form-group">
          <input type="password" class="form-control" placeholder="Senha" name="password" required>
        </div>

        <div class="form-group clearfix">
          <div class="checkbox-custom checkbox-inline checkbox-primary pull-left">
            <input type="checkbox" id="id_remember" name="remember">
            <label for="inputCheckbox">Lembrar-me</label>
          </div>
          <a href='#' class="pull-right" onclick="{goToForgotPass}">Esqueceu a senha?</a>
        </div>

        <button type="submit" class="btn btn-primary btn-block">Entrar</button>
      </form>

      <p>Não tem uma conta? <a href="{toRegister}">Registre-se</a>

      <footer class="page-copyright page-copyright-inverse">
        <p>Desenvolvido por <a href="http://criar.me">criar.me</a></p>
        <p>© 2015. Todos os direitos reservados.</p>
      </footer>
    </div>
  </div>

  <script>
    this.on('mount', function() {
      console.log("IM HERE!22");
    });

    goToForgotPass(e) {
      console.log("IM HERE!");
      RiotControl.trigger('router_go_forgotpass');
    }
  </script>
</my-login>
