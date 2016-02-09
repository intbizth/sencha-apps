Ext.define 'Balltoro.view.season.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-season'

    stores:
        seasons:
            type: 'store-seasons'
            autoLoad: yes
            remoteFilter: yes

        competitions:
            type: 'store-competitions'
            autoLoad: yes
