Ext.define 'Moboque.view.service.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-service'

    stores:
        services:
            type: 'store-services'
            autoLoad: yes
            pageSize: 25

        serviceCategories:
            type: 'store-service-categories'
            autoLoad: yes
            pageSize: 25

    createRecord: (record) ->
        return record if record
        return new (@data.services.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        serviceCategoryRecord = record.getServiceCategory()

        if serviceCategoryRecord and record.get('serviceCategory_id') != serviceCategoryRecord.getId()
            record.set('serviceCategory_id', serviceCategoryRecord.getId())
            record.commit()

        return record
