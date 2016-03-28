Ext.define 'Moboque.model.Group',
    extend: 'Moboque.model.Base'
    api: '/api/groups/'
    hasFileUpload: true

    fields: [
        name: 'name'
        type: 'string'
    ,
        name: 'color'
        type: 'string'
        defaultValue: '#ff0000'
    ,
        name: 'image'
        type: 'auto'
    ,
        name: 'event'
        reference:
            type: 'Event'
            role: 'event'
            associationKey: 'event'
            getterName: 'getEvent'
            setterName: 'setEvent'
    ]

    getEventName: ->
        event = @getEvent()

        return event.get("name") if event
        return ''

    writerTransform: fn: (data) ->

        if data.event
            data.event = data.event.id

        return data

    validators:
        name: 'presence'
        color: 'presence'
