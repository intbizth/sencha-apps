Ext.define 'Moboque.model.Group',
    extend: 'Moboque.model.Base'
    api: '/api/groups/'

    fields: [
        name: 'name'
        type: 'string'
    ,
        name: 'color'
        type: 'string'
    ]

    # hasMany: [
    #     name: 'events'
    #     model: 'GroupEvent'
    #     role: 'events'
    #     associationKey: 'events'
    #     getterName: 'getEvents'
    #     setterName: 'setEvents'
    #     storeConfig:
    #         type: 'store-group-events'
    # ]


    validators:
        name: 'presence'
        color: 'presence'
