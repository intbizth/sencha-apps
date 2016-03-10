Ext.define 'Moboque.view.report.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-report'

    stores:
        reports:
            type: 'store-reports'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.reports.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
