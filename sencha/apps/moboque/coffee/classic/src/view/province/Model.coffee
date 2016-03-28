Ext.define 'Moboque.view.province.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-province'

    stores:
        provinces:
            type: 'store-provinces'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.provinces.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
