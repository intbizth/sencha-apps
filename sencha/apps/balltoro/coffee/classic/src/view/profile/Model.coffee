Ext.define 'Balltoro.view.profile.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-profile'

    stores:
        profiles:
            type: 'store-profiles'
            autoLoad: yes

        countries:
            type: 'store-countries'
            autoLoad: yes
            pageSize: 200

        groups:
            type: 'store-profile-groups'
            autoLoad: yes
            pageSize: 200

    formulas:
        isLoading:
            get: ->


    createUser: (record) ->
        return record.getUser() if record
        return Ext.create 'Balltoro.model.User'

    createRecord: (record) ->
        return record if record
        return new (@data.profiles.getModel())()

    prepareData: (record) ->
        user = @createUser record
        record = @createRecord record
        country = user.getCountry()

        if country and user.get('country_id') != country.getId()
            user.set('country_id', country.getId())
            user.commit()

        record.setUser user

        return record
