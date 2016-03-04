Ext.define 'Moboque.view.group.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-group-form'

    stores:
        events:
            type: 'store-events'
            autoLoad: yes
            pageSize: 25

    formulas:
        event:
            get: ->
                @get('record').getEvent()
                # console.log 'get:::::: ', @get('record').getEvent()

            set: (val) ->
                # console.log 'set:::::: ', val
                @get('record').setEvent val
                console.log @get('record').getEvent()

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        eventId = @get('record').getPrevious('event_id')

        if eventId
            @get('record').setEvent @get('events').getById(eventId)
            record.commit()
