Ext.define 'Moboque.view.service_category.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-service-category'

    stores:
        serviceCategories:
            type: 'store-service-categories'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.serviceCategories.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
