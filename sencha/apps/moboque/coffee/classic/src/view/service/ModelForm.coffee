Ext.define 'Moboque.view.service.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-service-form'

    stores:
        serviceCategories:
            type: 'store-service-categories'
            autoLoad: yes
            pageSize: 25

    formulas:
        serviceCategory:
            get: ->
                @get('record').getServiceCategory()

            set: (val) ->
                @get('record').setServiceCategory val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        serviceCategoryId = @get('record').getPrevious('serviceCategory_id')

        if serviceCategoryId
            @get('record').setServiceCategory @get('serviceCategory').getById(serviceCategory_id)
            record.commit()
