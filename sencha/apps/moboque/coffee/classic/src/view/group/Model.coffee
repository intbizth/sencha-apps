Ext.define 'Moboque.view.group.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-group'

    stores:
        groups:
            type: 'store-groups'
            autoLoad: yes

        events:
            type: 'store-events'
            autoLoad: yes

    formulas:
        isLoading:
            get: ->

    createRecord: (record) ->
        return record if record
        return new (@data.groups.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
