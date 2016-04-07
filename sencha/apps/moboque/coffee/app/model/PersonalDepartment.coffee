Ext.define 'Moboque.model.PersonalDepartment',
    extend: 'Moboque.model.Base'
    api: '/api/personal-department/'
    hasFileUpload: true

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'thumbnail'
        type: 'auto'
    ]
