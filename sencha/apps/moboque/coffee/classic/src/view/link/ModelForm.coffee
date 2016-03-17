Ext.define 'Moboque.view.link.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-link-form'

    isDirty: ->
        @get('record').dirty

    formulas:
        isPhantom:
            get: -> @get('record').phantom

#    formulas:
#        currentGroups:
#            get: -> @get('record.groups').getData().getRange()
#            set: (rs) ->
#                @get('record.groups').loadRecords(rs || [])
#                # to mask model dirty
#                @get('record').set('groups', rs)

    onSubmitSuccess: -> @get('links').reload()

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()
