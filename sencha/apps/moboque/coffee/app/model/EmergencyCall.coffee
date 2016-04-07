Ext.define 'Moboque.model.EmergencyCall',
    extend: 'Moboque.model.Base'
    api: '/api/emergency-calls/'

    fields: [
        name: 'title'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ,
        name: 'tel'
        type: 'string'
    ]
