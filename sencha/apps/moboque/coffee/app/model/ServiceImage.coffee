Ext.define 'Moboque.model.ServiceImage',
    extend: 'Moboque.model.Base'
    api: '/api/service-images/'
    hasFileUpload: true

    fields: [
        name: 'description'
        type: 'string'
    ,
        name: 'service'
        reference:
            type: 'Service'
            role: 'service'
            associationKey: 'service'
            getterName: 'getService'
            setterName: 'setService'
    ,
        name: 'image'
        type: 'auto'
    ]

    getServiceTitle: ->
        service = @getService()
        return service.get("title") if service
        return ''

    validators:
        description: 'presence'

    writerTransform: fn: (data) ->
        if data.service
            data.service = data.service.id
        return data
