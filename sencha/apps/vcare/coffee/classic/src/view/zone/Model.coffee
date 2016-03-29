Ext.define 'Vcare.view.zone.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-zone'

    stores:
        zones:
            type: 'store-zones'
            autoLoad: yes

    createRecord: ->
        return new (@data.zones.getModel())()
