Ext.define 'Vcare.model.Shipment',
    extend: 'Vcare.model.Base'
    api: '/api/shipments/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'state'
        type: 'string'
        persist: false
    ,
        name: 'tracking'
        type: 'string'

    ]
