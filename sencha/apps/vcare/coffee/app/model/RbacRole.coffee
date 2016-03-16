Ext.define 'Vcare.model.RbacRole',
    extend: 'Vcare.model.Base'
    api: '/api/roles/'

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
            type: 'RbacRole'
            role: 'parent'
            associationKey: 'parent'
            getterName: 'getParent'
            setterName: 'setParent'
    ]

    writerTransform: fn: (data) ->
        if data.parent
            data.parent = data.parent.id

        return data
