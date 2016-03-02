Ext.define 'Moboque.model.PromoteCategory',
    extend: 'Moboque.model.Base'
    api: '/api/promote-categories/'

    fields: [
        name: 'title'
        type: 'string'
    ]

    validators:
        title: 'presence'
