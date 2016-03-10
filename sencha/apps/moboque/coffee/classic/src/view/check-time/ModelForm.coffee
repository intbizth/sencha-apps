Ext.define 'Moboque.view.check-time.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-check-time-form'

    stores:
        members:
            type: 'store-members'
            autoLoad: yes
            pageSize: 25

    getChecktime: -> @get('record').get('checktime')

    setChecktime: (date, time) ->
        originDate = @getChecktime()
        date = @setDateTimeInRecord(originDate, date, time)

        @get('record').set 'checktime', date
        return

    formulas:
        member:
            get: ->
                @get('record').getMember()

            set: (val) ->
                @get('record').setMember val

        checkDate:
            get: -> @getChecktime()
            set: (date) -> @setChecktime(date, null)

        checkTime:
            get: -> @getChecktime()
            set: (time) -> @setChecktime(null, time)

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        memberId = @get('record').getPrevious('member_id')

        if memberId
            @get('record').setMember @get('member').getById(memberId)
            record.commit()
