Ext.define 'Moboque.view.link.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-link'

    stores:
        links:
            type: 'store-link'
            autoLoad: yes


    createRecord: (record) ->
        return record if record
        return new (@data.links.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
