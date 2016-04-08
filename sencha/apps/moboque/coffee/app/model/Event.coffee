Ext.define 'Moboque.model.Event',
    extend: 'Moboque.model.Base'
    api: '/api/events/'

    fields: [
        name: 'name'
        type: 'string'
    ,
        name: 'location'
        type: 'string'
    ,
        name: 'start_date'
        type: 'date'
        dateWriteFormat: 'Y-m-d H:i:s'
    ,
        name: 'end_date'
        type: 'date'
        dateWriteFormat: 'Y-m-d H:i:s'
    ]
