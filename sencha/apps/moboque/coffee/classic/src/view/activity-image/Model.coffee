Ext.define 'Moboque.view.activity-image.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-activity-image'

    stores:
        activityImages:
            type: 'store-activity-images'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.activityImages.getModel())()

    prepareData: (record) ->
        record = @createRecord record
#        activityRecord = record.getPromoteImage()
#
#        if activityRecord and record.get('activity_id') != activityRecord.getId()
#            record.set('activity_id', activityRecord.getId())
#            record.commit()
#
        return record