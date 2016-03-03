Ext.define 'Moboque.view.promote.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-promote-form'

    stores:
        promoteCategories:
            type: 'store-promote-category'
            autoLoad: yes
            pageSize: 25

    formulas:
        promoteCategory:
            get: ->
                @get('record').getPromoteCategory()

            set: (val) ->
                # console.log val
                # @get('record')
                # return
                @get('record').setPromoteCategory val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty
        # @get('record').dirty || (promoteCategories && promoteCategories.dirty)

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        promoteCategoryId = @get('record').getPrevious('promoteCategory_id')

        if promoteCategoryId
            @get('record').setPromoteCategory @get('promoteCategories').getById(promoteCategoryId)
            record.commit()
