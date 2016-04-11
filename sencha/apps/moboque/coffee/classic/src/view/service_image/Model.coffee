Ext.define 'Moboque.view.service_image.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-service-image'

    stores:
        serviceImages:
            type: 'store-service-images'
            autoLoad: yes

        services:
            type: 'store-services'
            autoLoad: yes
            pageSize: 25

    createRecord: (record) ->
        return record if record
        return new (@data.serviceImages.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        serviceRecord = record.getService()

        if serviceRecord and record.get('service_id') != serviceRecord.getId()
            record.set('service_id', serviceRecord.getId())
            record.commit()

        return record
