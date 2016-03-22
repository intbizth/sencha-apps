Ext.define 'Moboque.view.link.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-link'

    stores:
        links:
            type: 'store-links'
            autoLoad: yes

    prepareData: (record) ->
        record = @createRecord record

        return record

    createRecord: (record) ->
        return record if record
        return new (@data.links.getModel())()
