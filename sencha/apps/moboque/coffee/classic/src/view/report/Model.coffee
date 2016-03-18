Ext.define 'Moboque.view.report.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-report'

    stores:
        reports:
            type: 'store-reports'
            autoLoad: yes

    prepareData: (record) ->
        record = @createRecord record

        return record

    createRecord: (record) ->
        return record if record
        return new (@data.links.getModel())()
