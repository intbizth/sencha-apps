Ext.define 'Ext.ux.form.SearchField',
    extend: 'Ext.form.field.Text'
    mixins: [ 'Ext.util.StoreHolder' ]
    alias: 'widget.searchfield'
    triggers:
        clear:
            weight: 0
            cls: Ext.baseCSSPrefix + 'form-clear-trigger'
            hidden: true
            handler: 'onClearClick'
            scope: 'this'
        search:
            weight: 1
            cls: Ext.baseCSSPrefix + 'form-search-trigger'
            handler: 'onSearchClick'
            scope: 'this'
    hasSearch: false
    paramName: 'search'

    initComponent: ->
        me = this
        me.callParent arguments
        me.on 'specialkey', (f, e) ->
            if e.getKey() == e.ENTER
                me.onSearchClick()
            return
        me.bindStore me.store or 'ext-empty-store', true
        return

    onBindStore: ->
        if @rendered
            me = this
            store = me.store
            proxy = store.getProxy()
            # We're going to use filtering
            store.setRemoteFilter true
            # Set up the proxy to encode the filter in the simplest way as a name/value pair
            proxy = me.store.getProxy()
            proxy.setFilterParam me.paramName

            proxy.encodeFilters = (filters) ->
                filters[0].getValue()
        return

    onClearClick: ->
        me = this
        activeFilter = me.activeFilter
        if activeFilter
            me.setValue ''
            me.store.getFilters().remove activeFilter
            me.activeFilter = null
            me.getTrigger('clear').hide()
            me.updateLayout()
        return

    onSearchClick: ->
        me = this
        value = me.getValue()
        if value.length > 0
            # Param name is ignored here since we use custom encoding in the proxy.
            # id is used by the Store to replace any previous filter
            me.activeFilter = new (Ext.util.Filter)(
                property: me.paramName
                value: value)
            me.store.getFilters().add me.activeFilter
            me.getTrigger('clear').show()
            me.updateLayout()
        return
