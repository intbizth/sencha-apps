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
        name: 'security_roles'
        type: 'auto'
    ,
        name: 'parent'
        reference:
            type: 'RbacRole'
            role: 'parent'
            associationKey: 'parent'
            getterName: 'getParent'
            setterName: 'setParent'
    ]

    hasMany: [
        name: 'permissions'
        model: 'RbacPermission'
        role: 'permissions'
        associationKey: 'permissions'
        getterName: 'getPermissions'
        setterName: 'setPermissions'
    ]

    writerTransform: fn: (data) ->
        if data.parent
            data.parent = data.parent.id

        return data
