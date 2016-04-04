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

    # AvailableOn, AvailableUntil
    getMasterVariant: ->
        return @get('record').getMasterVariant()

    getVariantAvailable: (fieldName) ->
        if variant = @getMasterVariant()
             return variant.get(fieldName)

        return

    setAvailable: (fieldName, date) ->
        if variant = @getMasterVariant()
            variant.set(fieldName, date)

        return

    # AvailableOn
    getAvailableOn: ->
        @getVariantAvailable('available_on')

    setAvailableOn: (date, time) ->
        originDate = @getAvailableOn()
        date = @setDateTimeInRecord(originDate, date, time)

        @setAvailable('available_on', date)

    # AvailableUntil
    getAvailableUntil: ->
        @getVariantAvailable('available_until')

    setAvailableUntil: (date, time) ->
        originDate = @getAvailableUntil()
        date = @setDateTimeInRecord(originDate, date, time)

        @setAvailable('available_until', date)

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
