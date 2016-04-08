Ext.define 'Moboque.view.report_image.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-report-image'

    stores:
        reportImages:
            type: 'store-report-images'
            autoLoad: yes

    prepareData: (record) ->
        record = @createRecord record

        return record

    createRecord: (record) ->
        return record if record
        return new (@data.reportImages.getModel())()
