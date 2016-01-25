Ext.define 'Toro.view.match.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-match'

    stores:
        matches:
            type: 'store-matches'
            autoLoad: yes

        matchEventTypes:
            type: 'store-match-event-types'
            autoLoad: yes
            pageSize: 50

        matchEventQualifiers:
            type: 'store-match-event-qualifiers'
            autoLoad: yes
            pageSize: 120

        homePlayers:
            type: 'store-home-players'
            pageSize: 100

        awayPlayers:
            type: 'store-away-players'
            pageSize: 100
