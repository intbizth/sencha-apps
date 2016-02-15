Ext.define 'Moboque.view.profile.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-profile-form'

    formulas:
        currentGroups:
           get: -> @get('record').getGroups().getIds()
           set: (v) -> @get('record').getGroups().loadData @get('groups').getByIds(v)

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
        @get('record').commit(); @get('record.user').commit()

    reject: ->
        @get('record').reject()

        return if !user = @get('record').getUser()

        # countryId = user.getPrevious('country_id')
        # user.reject()

        # if countryId
        #     user.setCountry @get('countries').getById(countryId)
        #     user.commit()
