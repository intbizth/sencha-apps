Ext.define 'Vcare.model.Address',
    extend: 'Vcare.model.Base'

    fields: [
        name: 'id'
        type: 'int'

#        name: 'code'
#        type: 'string'
#    ,
#        name: 'name'
#        type: 'string'
#        mapping: (data) -> data.code
#    ,
#        name: 'enabled'
#        type: 'boolean'
    ]

    getCode: -> @get 'code'
    getName: -> @get 'name'

    validators:
        code: 'presence'
