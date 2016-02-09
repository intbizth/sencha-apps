Ext.define('Ext.ux.form.SearchField', {
  extend: 'Ext.form.field.Text',
  mixins: ['Ext.util.StoreHolder'],
  alias: 'widget.searchfield',
  triggers: {
    clear: {
      weight: 0,
      cls: Ext.baseCSSPrefix + 'form-clear-trigger',
      hidden: true,
      handler: 'onClearClick',
      scope: 'this'
    },
    search: {
      weight: 1,
      cls: Ext.baseCSSPrefix + 'form-search-trigger',
      handler: 'onSearchClick',
      scope: 'this'
    }
  },
  hasSearch: false,
  paramName: 'search',
  initComponent: function() {
    var me;
    me = this;
    me.callParent(arguments);
    me.on('specialkey', function(f, e) {
      if (e.getKey() === e.ENTER) {
        me.onSearchClick();
      }
    });
    me.bindStore(me.store || 'ext-empty-store', true);
  },
  onBindStore: function() {
    var me, proxy, store;
    if (this.rendered) {
      me = this;
      store = me.store;
      proxy = store.getProxy();
      store.setRemoteFilter(true);
      proxy = me.store.getProxy();
      proxy.setFilterParam(me.paramName);
      proxy.encodeFilters = function(filters) {
        return filters[0].getValue();
      };
    }
  },
  onClearClick: function() {
    var activeFilter, me;
    me = this;
    activeFilter = me.activeFilter;
    if (activeFilter) {
      me.setValue('');
      me.store.getFilters().remove(activeFilter);
      me.activeFilter = null;
      me.getTrigger('clear').hide();
      me.updateLayout();
    }
  },
  onSearchClick: function() {
    var me, value;
    me = this;
    value = me.getValue();
    if (value.length > 0) {
      me.activeFilter = new Ext.util.Filter({
        property: me.paramName,
        value: value
      });
      me.store.getFilters().add(me.activeFilter);
      me.getTrigger('clear').show();
      me.updateLayout();
    }
  }
});
