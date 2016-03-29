Ext.define 'Vcare.view.product.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-product'

    stores:
        products:
            type: 'store-products'
            autoLoad: yes
