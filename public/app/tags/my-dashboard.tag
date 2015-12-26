<my-dashboard class="site-menubar-unfold">
  <my-navbar></my-navbar>
  <my-sidebar></my-sidebar>
  <my-content if={toDisplay == 'dashboard'}></my-content>
  <my-clients if={toDisplay == 'clients'}></my-clients>
  
  <script>
    this.mixin('rg.router');
    var self = this;
    
    this.router.on('go', function(curr, next) {
      if (curr.name === 'dashboard') {
        self.update({toDisplay: 'dashboard'});
        RiotControl.trigger('newStore_updateData');
      } else if (curr.name === 'clients') {
        self.update({toDisplay: 'clients'});
        RiotControl.trigger('clientStore_getClients');
      }
    });
    
  </script>
</my-dashboard>
