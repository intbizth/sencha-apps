Ext.define 'Moboque.view.promote.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-promote-form'

    stores:
        promoteCategories:
            type: 'store-promote-category'
            autoLoad: yes
            pageSize: 25

    # TODO Check this promoteCategory GodoakBrutal & P.Yokky
    formulas:
        promoteCategory:
            get: ->
                @get('record').getPromoteCategory()

            set: (val) ->
                @get('record').setPromoteCategory val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        promoteCategoryId = @get('record').getPrevious('promoteCategory_id')

        if promoteCategoryId
            @get('record').setPromoteCategory @get('promoteCategories').getById(promoteCategoryId)
            record.commit()
