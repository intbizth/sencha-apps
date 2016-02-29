Ext.define 'Moboque.view.group.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-group-form'

    stores:
        events:
            type: 'store-events'
            autoLoad: yes
            pageSize: 25

    # TODO Check this event GodoakBrutal & P.Yokky
    formulas:
        event:
            get: ->
                @get('record').getEvent()

            set: (val) ->
                # console.log val
                # @get('record')
                # return
                @get('record').setEvent val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty
        # @get('record').dirty || (events && events.dirty)

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        eventId = @get('record').getPrevious('event_id')

        if eventId
            @get('record').setEvent @get('events').getById(eventId)
            record.commit()
