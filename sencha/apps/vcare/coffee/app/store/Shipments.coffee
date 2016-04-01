Ext.define 'Vcare.store.Shipments',
    extend: 'Vcare.store.Base'
    model: 'Vcare.model.Shipment'
    alias: 'store.store-shipments'

    splitShipment: (options) ->
          me = @
          options.params['_method'] = options.method || 'PATCH'
          callback = options.callback || Ext.emptyFn
          scope = options.scope || me

          Ext.Ajax.request
              method: 'POST'
              url: '/api/shipments/{id}/split?' +
                Ext.Object.toQueryString({
                  items: options.items
                },true)
              params: options.params

              success: (response) ->
                  me.reload
                      callback: (rs, operation, success) ->
                          callback.call scope, yes, rs

              failure: (response) ->
                  callback.call scope, no, Ext.decode(response.responseText)

