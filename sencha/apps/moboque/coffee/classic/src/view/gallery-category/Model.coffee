Ext.define 'Moboque.view.gallery-category.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-gallery-category'

    stores:
        galleryCategories:
            type: 'store-gallery-categories'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
        return new (@data.galleryCategories.getModel())()

    prepareData: (record) ->
        record = @createRecord record

        return record
