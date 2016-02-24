Ext.define 'Moboque.view.group.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-group-form'

    formulas:
        # currentEvents:
        #    get: -> @get('record').getEvents().getId()
        #    set: (v) -> @get('record').getEvents().loadData @get('events').getById(v)

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    # commit: ->
    #     @get('record').commit(); @get('record.user').commit()

    # reject: ->
    #     @get('record').reject()
