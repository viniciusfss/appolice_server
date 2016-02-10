<my-dashboard class="site-menubar-unfold">
  <my-navbar></my-navbar>
  <my-sidebar></my-sidebar>
  <my-content if={toDisplay == 'dashboard'}></my-content>
  <my-clients if={toDisplay == 'clients'}></my-clients>
  <my-policies if={toDisplay == 'policies'}></my-policies>
  <my-car-policies if={toDisplay == 'car-policies'}></my-car-policies>
  <my-messages if={toDisplay == 'messages'}></my-messages>

  <script>
    this.mixin('rg.router');
    var self = this;

    this.router.on('go', function(curr, next) {
      if (curr.name === 'dashboard') {
        self.update({toDisplay: 'dashboard'});
        RiotControl.trigger('userStore_get_account_details');
      } else if (curr.name === 'clients') {
        self.update({toDisplay: 'clients'});
        RiotControl.trigger('clientStore_getClients');
      } else if (curr.name === 'policies') {
        self.update({toDisplay: 'policies'});
        RiotControl.trigger('policyStore_getPolicies');
      } else if (curr.name === 'car-policies') {
        self.update({toDisplay: 'car-policies'});
        RiotControl.trigger('policyStore_getCarPolicies');
      } else if (curr.name === 'messages') {
        self.update({toDisplay: 'messages'});
      }
    });

  </script>
</my-dashboard>
