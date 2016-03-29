Ext.define 'Vcare.view.tax.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-tax'

    stores:
        taxs:
            type: 'store-taxs'
            autoLoad: yes
        taxcategories:
            type: 'store-taxcategories'
            autoLoad: yes
        zones:
            type: 'store-zones'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.taxs.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        return record
