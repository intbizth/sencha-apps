Ext.define 'Moboque.view.promote-category.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-promote-category'

    stores:
        promotes:
            type: 'store-promote-categories'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.promotes.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
