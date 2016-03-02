Ext.define 'Moboque.view.promote.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-promote-form'

    stores:
        promotesCat:
            type: 'store-promote-category'
            autoLoad: yes
            pageSize: 25

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

    formulas:
        isPhantom:
            get: -> @get('record').phantom

        promoteSaveTitle:
            get: ->
                @get('record').getPromoteCategory()

            set: (val) ->
                @get('record').setPromoteCategory val


    reject: ->
        promoteCatId = @get('record').getPrevious('promoteCategory_id')
        if promoteCatId
            @get('record').setPromoteCategory() @get('promotes').getById(promoteCatId)
            record.commit()
