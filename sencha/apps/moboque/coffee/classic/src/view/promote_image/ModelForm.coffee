Ext.define 'Moboque.view.promote_image.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-promote-image-form'

    stores:
        promoteList:
            type: 'store-promotes'
            autoLoad: yes
            pageSize: 25

    formulas:
        promote:
            get: ->
                @get('record').getPromote()

            set: (val) ->
                @get('record').setPromote val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        promoteId = @get('record').getPrevious('promote_id')

        if promoteId
            @get('record').setPromote @get('promoteList').getById(promoteId)
            record.commit()
