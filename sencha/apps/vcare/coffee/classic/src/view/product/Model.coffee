Ext.define 'Vcare.view.product.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-product'

    stores:
        products:
            type: 'store-products'
            autoLoad: yes

    createMasterVariant: (record) ->
        return record.getMasterVariant() if record and record.getMasterVariant()
        return Ext.create 'Vcare.model.ProductVariant'

    createRecord: (record) ->
        return record if record
        return new (@data.products.getModel())()

    prepareData: (record) ->
        variant = @createMasterVariant record
        record = @createRecord record
        record.setMasterVariant variant

        return record
