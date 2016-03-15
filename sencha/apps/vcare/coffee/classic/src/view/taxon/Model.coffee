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

        store = if type == 'brand' then 'brands' else 'categories'

        return new (@data[store].getModel({
            current_locale: @get('defaultLocale')
        }))()
