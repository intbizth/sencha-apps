Ext.define 'Moboque.view.emergency-call.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-emergency-call-form'

    # formulas:
    #     currentGroups:
    #        get: -> @get('record').getGroups().getIds()
    #        set: (v) -> @get('record').getGroups().loadData @get('groups').getByIds(v)

    #     country:
    #         get: ->
    #             user = @get('record.user')
    #             user.getCountry() if user
    #         set: (val) ->
    #             @get('record.user').setCountry val

    #     isPhantom:
    #         get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    # commit: ->
    #     @get('record').commit(); @get('record.user').commit()

    # reject: ->
    #     @get('record').reject()

    getStartDate: -> @get('record').get('start_date')
    setStartDate: (date, time) ->
        originDate = @getStartDate()
        date = @setDateTimeInRecord(originDate, date, time)

        @get('record').set 'start_date', date
        return

    getEndDate: -> @get('record').get('end_date')
    setEndDate: (date, time) ->
        originDate = @getEndDate()
        date = @setDateTimeInRecord(originDate, date, time)

        @get('record').set 'end_date', date
        return

    formulas:
        startDate:
            get: -> @getStartDate()
            set: (date) -> @setStartDate(date, null)

        startTime:
            get: -> @getStartDate()
            set: (time) -> @setStartDate(null, time)

        endDate:
            get: -> @getEndDate()
            set: (date) -> @setEndDate(date, null)

        endTime:
            get: -> @getEndDate()
            set: (time) -> @setEndDate(null, time)

        isPhantom:
            get: -> @get('record').phantom
