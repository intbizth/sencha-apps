Ext.define 'Moboque.model.District',
    extend: 'Moboque.model.Base'
    api: '/api/districts/'

    fields: [
        name: 'name'
        type: 'string'
    ,
        name: 'province'
        reference:
            type: 'Province'
            role: 'province'
            associationKey: 'province'
            getterName: 'getProvince'
            setterName: 'setProvince'
    ]

    getProvinceName: ->
        province = @getProvince()

        return province.get("name") if province
        return ''

    writerTransform: fn: (data) ->

        if data.province
            data.province = data.province.id

        return data

    validators:
        name: 'presence'
