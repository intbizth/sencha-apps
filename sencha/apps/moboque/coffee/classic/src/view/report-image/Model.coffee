Ext.define 'Moboque.view.report-image.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-report-image'

    stores:
        reportsImage:
            type: 'store-report-images'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.reportsImage.getModel())()

    prepareData: (record) ->
        record = @createRecord record
#        reportRecord = record.getReportImage()
#
#        if reportRecord and record.get('report_id') != reportRecord.getId()
#            record.set('report_id', reportRecord.getId())
#            record.commit()
#
        return record
