Ext.define 'Balltoro.view.match.event.EventView',
    extend: 'Balltoro.view.base.Window'
    alias: 'widget.wg-match-event'

    controller: 'ctrl-match-event'

    layout: 'border'
    modal: yes
    closable: yes
    split: yes
    referenceHolder: yes

    bind:
        title: '{title}'
        data: '{match}'

    items: [
        xtype: 'wg-match-event-cardlist'
        region: 'west'
        margin: '0 5 0 0'
        scrollable: yes
        width: '50%'
        reference: 'refMatchCardList'
    ,
        xtype: 'wg-match-event-goallist'
        region:'east'
        margin: '0 0 0 5'
        scrollable: yes
        width: '50%'
        reference: 'refMatchGoalList'
    ]
