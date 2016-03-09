Ext.define 'Vcare.view.taxon.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-taxon'

    stores:
        categories:
            type: 'store-taxon-categories'
            autoLoad: yes

        locales:
            type: 'store-locales'
            autoLoad: yes

    createRecord: (record, type) ->
        return record if record

        switch type
            when 'brand' then store = 'brands'
            else store = 'categories'

        return new (@data[store].getModel())()

    prepareData: (record, type) ->
        record = @createRecord record, type

        return record
