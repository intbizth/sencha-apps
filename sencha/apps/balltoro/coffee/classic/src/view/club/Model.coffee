Ext.define 'Balltoro.view.club.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-club-list'

    stores:
        clubs:
            type: 'store-clubs'
            autoLoad: yes

        countries:
            type: 'store-countries'
            pageSize: 100

        club_classes:
            type: 'store-club-classes'
            autoLoad: yes

        clubPersonals:
            type: 'store-club-personals'
            autoLoad: yes
