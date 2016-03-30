Ext.define 'Vcare.view.product.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-product'

    stores:
        products:
            type: 'store-products'
            autoLoad: yes

        locales:
            type: 'store-locales'
            autoLoad: yes
            pageSize: no

        # taxons:
        #     type: 'store-taxons'
        #     autoLoad: yes

    createRecord: (record) ->
        return record if record

        console.log @get('defaultLocale')

        return new (@data.products.getModel(
            current_locale: @get('defaultLocale')
        ))()
