Ext.define 'Moboque.view.service-image.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-service-image-form'

    formulas:
        service:
            get: ->  @get('record').getService()
            set: (val) ->
                @get('record').setService val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        serviceId = @get('record').getPrevious('service_id')

        if serviceId
            @get('record').setService @get('serviceList').getById(serviceId)
            record.commit()
