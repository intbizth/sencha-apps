Ext.define 'Vcare.model.Shipment',
    extend: 'Vcare.model.Base'
    api: '/api/shipments/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'state'
        type: 'string'
    ,
        name: 'created_at'
        type: 'date'
    ,
        name: 'updated_at'
        type: 'date'
    ]
