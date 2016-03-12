Ext.define 'Vcare.view.taxon.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-taxon'

    stores:
        categories:
            type: 'store-taxon-categories'
            autoLoad: yes

        brands:
            type: 'store-taxon-brands'
            autoLoad: yes

        locales:
            type: 'store-locales'
            autoLoad: yes

    createRecord: (record, type) ->
        return record if record

        switch type
            when 'brand' then store = 'brands'
            else store = 'categories'

        console.log @get('defaultLocale')

        return new (@data[store].getModel({
            current_locale: @get('defaultLocale')
        }))()

    prepareData: (record, type) ->
        record = @createRecord record, type

        return record
