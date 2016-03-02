Ext.define 'Vcare.view.locale.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-locale'

    stores:
        locales:
            type: 'store-locales'
            autoLoad: yes

        localecodes:
            type: 'store-localecodes'
            autoLoad: yes

        ulocalecodes:
            type: 'store-ulocalecodes'
            autoLoad: yes
            sorters:[
                property: 'name'
                direction: 'asc'
            ]
            filters: (item) ->
                store = Ext.getStore('locales')
                return !store.findRecord('code',item.data.abbr)


    createRecord: (record) ->
        return record if record
        return new (@data.locales.getModel())()

    prepareData: (record) ->
        record = @createRecord record
        return record