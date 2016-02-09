Ext.define 'Balltoro.view.match.personal.PersonalView',
    extend: 'Balltoro.view.base.Window'
    alias: 'widget.wg-match-personal'

    controller: 'ctrl-match-personal'

    layout: 'border'
    modal: yes
    closable: yes
    split: yes
    referenceHolder: yes

    bind:
        title: '{title}'
        data: '{match}'

    items: [
        xtype: 'wg-match-personal-homelist'
        region: 'west'
        margin: '0 5 0 0'
        scrollable: yes
        width: '50%'
        reference: 'refPersonalHomeList'
        itemId: 'home'
    ,
        xtype: 'wg-match-personal-awaylist'
        region:'east'
        margin: '0 0 0 5'
        scrollable: yes
        width: '50%'
        reference: 'refPersonalAwayList'
        itemId: 'away'
    ]
