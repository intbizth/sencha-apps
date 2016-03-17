Ext.define 'Vcare.model.RbacPermission',
    extend: 'Vcare.model.Base'
    api: '/api/permissions/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'code'
        type: 'string'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ,
        name: 'parent'
        reference:
            type: 'RbacPermission'
            role: 'parent'
            associationKey: 'parent'
            getterName: 'getParent'
            setterName: 'setParent'
    ]

    writerTransform: fn: (data) ->
        if data.parent
            data.parent = data.parent.id

        return data
