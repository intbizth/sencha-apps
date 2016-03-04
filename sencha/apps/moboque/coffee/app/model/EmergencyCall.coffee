Ext.define 'Moboque.model.EmergencyCall',
    extend: 'Moboque.model.Base'
    api: '/api/emergency-call/'

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

    validators:
        title: 'presence'
        description: 'presence'
        tel: 'presence'
