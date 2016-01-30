Ext.define 'Toro.view.profile.ModelForm',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-profile-form'

    formulas:
        "country":
            get: (get) -> get('user').getCountry()
            set: (val) -> console.log val; @get('user').setCountry(val)
        "groupsIds":
            get: (get) -> get('profile').groups().getIds()
            set: (ids) -> @get('profile').updateGroups @get('groups').getByIds(ids)

    preSubmit: (profile) ->
        # can't track ref change! :(, isDirty will away to be `true`
        user = @get('user')
        console.log user
        return
        #userData = user.getSubmitData() || {}
        #userData.country = if @get('country') then @get('country').getId() else null

        profile.def 'groups', profile.getGroupIds()
        profile.def 'user', userData

    postSubmit: (profile) ->
        profile.undef 'user', 'groups'

        if profile.phantom
            profiles = @get('profiles')
            profiles.add profile
            profiles.commitChanges()
