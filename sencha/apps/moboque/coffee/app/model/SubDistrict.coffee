Ext.define 'Moboque.model.SubDistrict',
    extend: 'Moboque.model.Base'
    api: '/api/sub-districts/'

    fields: [
        name: 'name'
        type: 'string'
    ,
        name: 'district'
        reference:
            type: 'District'
            role: 'district'
            associationKey: 'district'
            getterName: 'getDistrict'
            setterName: 'setDistrict'
    ]

    getDistrictName: ->
        district = @getDistrict()

        return district.get("name") if district
        return ''

    writerTransform: fn: (data) ->

        if data.district
            data.district = data.district.id

        return data

    validators:
        name: 'presence'
