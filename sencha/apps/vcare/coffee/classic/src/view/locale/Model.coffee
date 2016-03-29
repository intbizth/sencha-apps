Ext.define 'Vcare.view.locale.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-locale'

    stores:
        locales:
            type: 'store-locales'
            autoLoad: yes

    createRecord: ->
        return new (@data.locales.getModel())()
