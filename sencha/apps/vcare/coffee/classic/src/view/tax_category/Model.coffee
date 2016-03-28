Ext.define 'Vcare.view.tax-category.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-tax-category'

    stores:
        taxcategories:
            type: 'store-taxcategories'
            autoLoad: yes


    createRecord: (record) ->
        return record if record
        return new (@data.taxs.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        return record
