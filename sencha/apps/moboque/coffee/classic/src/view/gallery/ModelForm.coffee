Ext.define 'Moboque.view.gallery.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-gallery-form'

    formulas:
        galleryCategory:
            get: -> @get('record').getGalleryCategory()
            set: (val) ->
                @get('record').setGalleryCategory val
                console.log @get('record').getGalleryCategory()

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        galleryCategoryId = @get('record').getPrevious('galleryCategory_id')

        if eventId
            @get('record').setEvent @get('galleryCategories').getById(eventId)
            record.commit()
