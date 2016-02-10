<my-messages>
  <div class="page animsition" style="animation-duration: 0.8s; opacity: 1;">
    <div class="page-header">
      <h1 class="page-title">Mensagens <small>{client.name || client.id}</small></h1>
      <div class="page-header-actions">
        <button class="btn btn-info" onclick="{sendMsg}">
          <span class="fa fa-share"></span> Enviar</button>
      </div>
    </div>
    <div class="page-content container-fluid">
      <input class="form-control" type="text" name="message" placeholder="Sua mensagem aqui."/>
      <hr>
      <div if={msgs.length <= 0}>
        <div class="panel">
          <header class="panel-heading">
            <h3 class="panel-title">Nenhuma mensagem</h3>
          </header>
          <div class="panel-body">
            <p>Não há mensagens.</p>
          </div>
        </div>
      </div>
      <div if="{msgs.length > 0}">
        <div class="panel" each={msg in msgs.reverse()}>
          <header class="panel-heading">
            <h3 class="panel-title">{msg.text}</h3>
          </header>
          <div class="panel-body">
             <p>Por: {msg.from}</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
    this.mixin('rg.router');
    self = this;
    this.msgs = [];
    this.client = {};

    this.router.on('go', function (curr, prev) {
      if (curr.name == 'messages') {
        self.client = curr.params;
        msgs = curr.params.messages;
        self.update({msgs: msgs})
      }
    });

    RiotControl.on('clientStore_sendMsg_done', function (msgs) {
      self.update({msgs: msgs});
    });

    sendMsg() {
      msg = {
        id: self.client.id,
        from: "me",
        text: self.message.value
      };

      RiotControl.trigger('clientStore_sendMsg', msg);
      self.message.value = "";
      self.update();
    };

  </script>
</my-messages>
