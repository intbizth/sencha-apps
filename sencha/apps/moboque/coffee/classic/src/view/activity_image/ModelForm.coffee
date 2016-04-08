Ext.define 'Moboque.view.activity_image.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-activity-image-form'

    formulas:
        activity:
            get: ->  @get('record').getActivity()
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
            @get('record').setActivity @get('activityList').getById(activityId)
            record.commit()
