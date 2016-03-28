Ext.define 'Moboque.view.meet.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-meet'

    stores:
        meets:
            type: 'store-meets'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.meets.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
