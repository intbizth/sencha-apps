Ext.define 'Moboque.model.Gallery',
    extend: 'Moboque.model.Base'
    api: '/api/galleries/'
    hasFileUpload: true

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'sub_title'
        type: 'string'
    # ,
    #     name: 'image'
    #     type: 'auto'
    ,
        name: 'galleryCategory'
        reference:
            type: 'GalleryCategory'
            role: 'galleryCategory'
            associationKey: 'gallery_category'
            getterName: 'getGalleryCategory'
            setterName: 'setGalleryCategory'
    ]

    getGalleryCategoryName: ->
        galleryCategory = @getGalleryCategory()

        return galleryCategory.get("title") if galleryCategory
        return ''

    writerTransform: fn: (data) ->

        if data.galleryCategory
            data.galleryCategory = data.galleryCategory.id

        return data

    validators:
        title: 'presence'
        sub_title: 'presence'
