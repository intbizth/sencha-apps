Ext.define 'Moboque.model.PersonalDepartment',
    extend: 'Moboque.model.Base'
    api: '/api/personal-department/'

    fields: [
        name: 'title'
        type: 'string'
    ]

    validators:
        title: 'presence'
