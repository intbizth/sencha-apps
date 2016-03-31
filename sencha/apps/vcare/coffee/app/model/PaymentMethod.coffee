Ext.define 'Vcare.model.PaymentMethod',
    extend: 'Vcare.model.Translatable'
    api: '/api/payment-methods/'

    requires: [
        'Vcare.store.PaymentGateways'
    ]

    associationWriterIdBased: yes
    translationFields: ['name', 'description']

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        type: 'string'
        persist: no
        convert: (v, r) -> r.getName()
    ,
        name: 'description'
        type: 'string'
        persist: no
        convert: (v, r) -> r.getDescription()
    ,
        name: 'enabled'
        type: 'boolean'
    ,
        name: 'gateway'
        convert: (v, r) ->
            v = v.get('code') if v && v.isModel
            store = Ext.data.StoreManager.lookup('store-payment-gateways')
            store = Ext.create('Vcare.store.PaymentGateways', {
                autoLoad: yes
                pageSize: no
                listeners: load: (store) ->
                    r.beginEdit()
                    r.set('gateway', store.findRecord('code', v))
                    r.endEdit(no)
                    r.commit(no)

            }) if !store && v

            return v if !v
            return store.findRecord('code', v)
    ]

    getName: -> @trans 'name'
    getDescription: -> @trans 'description'
    getGatewayName: -> @get('gateway') && @get('gateway').get('name')

    validators:
        code: 'presence'

    writerTransform: fn: (data) ->
        if data.gateway
            data.gateway = data.gateway.id

        return data