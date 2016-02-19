Ext.define 'Moboque.view.group.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-group-form'

    formulas:
    #     currentGroups:
    #        get: -> @get('record').getGroups().getIds()
    #        set: (v) -> @get('record').getGroups().loadData @get('groups').getByIds(v)

    #     country:
    #         get: ->
    #             user = @get('record.user')
    #             user.getCountry() if user
    #         set: (val) ->
    #             @get('record.user').setCountry val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    # commit: ->
    #     @get('record').commit(); @get('record.user').commit()

    # reject: ->
    #     @get('record').reject()
