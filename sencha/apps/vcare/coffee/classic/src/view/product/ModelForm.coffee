Ext.define 'Vcare.view.product.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-product-form'

    formulas:
        availableOnDate:
            get: -> @getAvailableOn()
            set: (date) -> @setAvailableOn(date, null)

        availableOnTime:
            get: -> @getAvailableOn()
            set: (time) -> @setAvailableOn(null, time)

        availableUntilDate:
            get: -> @getAvailableUntil()
            set: (date) -> @setAvailableUntil(date, null)

        availableUntilTime:
            get: -> @getAvailableUntil()
            set: (time) -> @setAvailableUntil(null, time)

    #### >> todo not duplicate & this function is incomplete
    getAvailableOn: ->
        if variant = @get('record').getMasterVariant()
            return variant.get('available_on')

        return

    # setAvailableOn: (date, time) ->
    #     originDate = @getAvailableOn()
    #     date = @setDateTimeInRecord(originDate, date, time)

    #     @get('record').set 'available_on', date
    #     return

    getAvailableUntil: ->
        if variant = @get('record').getMasterVariant()
            return variant.get('available_until')

        return

    # setAvailableUntil: (date, time) ->
    #     originDate = @getAvailableUntil()
    #     date = @setDateTimeInRecord(originDate, date, time)

    #     @get('record').set 'available_until', date
    #     return
    #### <<

    isDirty: ->
        @get('record').dirty || @get('record.master_variant').dirty

    commit: ->
        # need to call master variant first
        @get('record.master_variant').commit()
        @get('record').commit()

    reject: ->
        # need to call master variant first
        @get('record').getMasterVariant().reject()
        @get('record').reject()

    beforeSubmit: (record) -> record.updateTranslations()
    beforeCancel: (record) -> record.updateTranslations()
    onSubmitSuccess: -> @get('products').reload()
