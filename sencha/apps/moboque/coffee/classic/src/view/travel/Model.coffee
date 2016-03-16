Ext.define 'Moboque.view.travel.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-travel'

    stores:
        travels:
            type: 'store-travel'
            autoLoad: yes
        locales:
            type: 'store-locale'
            autoLoad: yes

    createRecord: (record) ->
        return record if record
#        return new (@data.travels.getModel())()
        console.log @get('defaultLocale')
        return new (@data.travels.getModel({
            current_locale: @get('defaultLocale')
        }))()

    prepareData: (record) ->
        record = @createRecord record

        return record
