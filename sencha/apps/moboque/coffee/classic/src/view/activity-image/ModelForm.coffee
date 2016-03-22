Ext.define 'Moboque.view.activity-image.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-activity-image-form'

    stores:
        activities:
            type: 'store-activities'
            autoLoad: yes
            pageSize: 25

    formulas:
        activity:
            get: ->
                @get('record').getActivity()

            set: (val) ->
                @get('record').setActivity val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        activityId = @get('record').getPrevious('activity_id')

        if activityId
            @get('record').setActivity @get('activities').getById(activityId)
            record.commit()
