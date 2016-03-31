Ext.define 'Moboque.model.GalleryCategory',
    extend: 'Moboque.model.Base'
    api: '/api/gallery-categories/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'sub_title'
        type: 'string'
    ]

    validators:
        title: 'presence'
        sub_title: 'presence'
