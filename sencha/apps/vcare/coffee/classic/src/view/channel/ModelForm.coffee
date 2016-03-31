Ext.define 'Vcare.view.channel.ModelForm',
    extend: 'Vcare.view.base.ViewModel'
    alias: 'viewmodel.vm-channel-form'

    collectionGetter: (key) ->
        @get("record.#{key}").getData().getRange()

    collectionSetter: (key, val) ->
        @get("record.#{key}").loadRecords(val || [])
        # to mask model dirty
        @get('record').set(key, val)

    formulas:
        selectedCurrencies:
            get: -> @collectionGetter('currencies')
            set: (rs) -> @collectionSetter('currencies', rs)

        selectedTaxonomies:
            get: -> @collectionGetter('taxonomies')
            set: (rs) -> @collectionSetter('taxonomies', rs)

        selectedLocales:
            get: -> @collectionGetter('locales')
            set: (rs) -> @collectionSetter('locales', rs)

        selectedShippingMethods:
            get: -> @collectionGetter('shipping_methods')
            set: (rs) -> @collectionSetter('shipping_methods', rs)

        selectedPaymentMethods:
            get: -> @collectionGetter('payment_methods')
            set: (rs) -> @collectionSetter('payment_methods', rs)

    isDirty: -> @get('record').dirty
    commit: -> @get('record').commit()
    reject: -> @get('record').reject()
