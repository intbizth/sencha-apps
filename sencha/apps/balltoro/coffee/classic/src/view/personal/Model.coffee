Ext.define 'Balltoro.view.personal.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-personal'

    stores:
        personals:
            type: 'store-personals'
            remoteFilter: yes
            autoLoad: yes

        countries:
            type: 'store-countries'
            pageSize: 100

        positions:
            type: 'store-personal-positions'
            autoLoad: yes

        clubs:
            type: 'store-clubs'
            autoLoad: yes
