Ext.define 'Toro.view.profile.Model',
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

    createUser: (record) ->
        return record.getUser() if record
        return Ext.create 'Toro.model.User'

    createRecord: (record) ->
        return record if record
        return new (@data.profiles.getModel())()

    prepareData: (record) ->
        user = @createUser record
        record = @createRecord record
        record.setUser user

        return record
