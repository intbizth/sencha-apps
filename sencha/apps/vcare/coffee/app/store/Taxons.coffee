Ext.define 'Vcare.store.Taxons',
    extend: 'Vcare.store.Base'
    model: 'Vcare.model.Taxon'
    alias: 'store.store-taxons'
    storeId: 'store-taxons'

    # @private
    #originApis: null

    #listeners:
        # replace url holder
        # beforeload: (store, operation) ->
        #     proxy = operation.getProxy()
        #     filters = store.getFilters()

        #     if (!@originApis)
        #         @originApi = proxy.getApi()

        #     originApi = {}

        #     filters.each (item) =>
        #         if item.getId() == 'taxonomy'
        #             for api of @originApi
        #                 originApi[api] = @originApi[api].replace '{taxonomy}', item.getValue()

        #             store.removeFilter item, yes

        #     operation.setFilters filters

        #     if originApi.read
        #         proxy.setApi originApi
