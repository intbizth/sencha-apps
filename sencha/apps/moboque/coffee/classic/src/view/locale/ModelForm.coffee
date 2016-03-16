Ext.define 'Moboque.view.locale.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-locale-form'

    stores:
        localeCategories:
            type: 'store-locale-category'
            autoLoad: yes
            pageSize: 25

    # TODO Check this localeCategory GodoakBrutal & P.Yokky
    formulas:
        localeCategory:
            get: ->
                @get('record').getLocaleCategory()

            set: (val) ->
                @get('record').setLocaleCategory val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        localeCategoryId = @get('record').getPrevious('localeCategory_id')

        if localeCategoryId
            @get('record').setLocaleCategory @get('localeCategories').getById(localeCategoryId)
            record.commit()
