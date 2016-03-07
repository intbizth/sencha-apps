Ext.define 'Moboque.view.promote-image.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-promote-image-form'

    stores:
        promoteList:
            type: 'store-promote'
            autoLoad: yes
            pageSize: 25

    formulas:
#        promote:
#            get: ->
#                @get('record').getPromoteImage()
#
#            set: (val) ->
#                @get('record').setPromoteImage val

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
            @get('record').setPromoteImage @get('promoteList').getById(promoteId)
            record.commit()
