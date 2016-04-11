Ext.define 'Moboque.view.activity_image.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-activity-image'

    stores:
        activityImages:
            type: 'store-activity-images'
            autoLoad: yes

        activities:
            type: 'store-activities'
            autoLoad: yes
            pageSize: 25

    createRecord: (record) ->
        return record if record
        return new (@data.activityImages.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        activityRecord = record.getActivity()

        if activityRecord and record.get('activity_id') != activityRecord.getId()
            record.set('activity_id', activityRecord.getId())
            record.commit()

        return record
