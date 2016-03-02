Ext.define 'Moboque.view.activity.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-activity-form'

    stores:
        activities:
            type: 'store-activities'
            autoLoad: yes
            pageSize: 25

    formulas:
        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()
