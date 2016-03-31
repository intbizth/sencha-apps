Ext.define 'Moboque.view.gallery.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-gallery'

    stores:
        galleries:
            type: 'store-galleries'
            autoLoad: yes

        galleryCategories:
            type: 'store-gallery-categories'
            autoLoad: yes
            pageSize: 25

    createRecord: (record) ->
        return record if record
        return new (@data.galleries.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        galleryCategoryRecord = record.getGalleryCategory()

        if galleryCategoryRecord and record.get('galleryCategory_id') != galleryCategoryRecord.getId()
            record.set('galleryCategory_id', galleryCategoryRecord.getId())
            record.commit()

        return record
