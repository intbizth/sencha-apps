Ext.define 'Vcare.view.customer.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-customer-form'

    formulas:
        currentGroups:
            get: -> @get('record').getGroups().getIds()
            set: (v) ->
                groups = @get('groups').getByIds(v)
                @get('record').getGroups().loadData groups

        country:
            get: ->
                user = @get('record.user')
                user.getCountry() if user
            set: (val) ->
                @get('record.user').setCountry val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        user = @get('record.user')
        @get('record').dirty || (user && user.dirty)

    commit: ->
        @get('record').commit()
        @get('record.user').commit()

    reject: ->
        @get('record').reject()

        return if !user = @get('record').getUser()

        localeId = user.getPrevious('locale')
        user.reject()

        if localeId
            user.setLocale @get('locales').getById(localeId)
            user.commit()
