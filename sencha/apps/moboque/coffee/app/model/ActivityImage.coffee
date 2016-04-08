Ext.define 'Moboque.model.ActivityImage',
    extend: 'Moboque.model.Base'
    api: '/api/activity-images/'
    hasFileUpload: true

    fields: [
        name: 'description'
        type: 'string'
    ,
        name: 'activity'
        reference:
            type: 'Activity'
            role: 'activity'
            associationKey: 'activity'
            getterName: 'getActivity'
            setterName: 'setActivity'
    ,
        name: 'image'
        type: 'auto'
    ]

    getActivityTitle: ->
        activity = @getActivity()
        return activity.get("title") if activity
        return ''

    writerTransform: fn: (data) ->
        if data.activity
            data.activity = data.activity.id
        return data
