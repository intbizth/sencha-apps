Ext.define 'Toro.view.match.event.SubstitutionView',
    extend: 'Toro.view.base.Window'
    alias: 'widget.wg-match-event-substitution'

    controller: 'ctrl-match-event'

    bind:
        title: '{title}'

    layout:
        type: 'hbox'
        align: 'stretch'

    modal: yes
    closable: yes
    referenceHolder: yes

    items: [
        xtype: 'wg-match-event-substitutionlist'
        flex: 1
    ]
