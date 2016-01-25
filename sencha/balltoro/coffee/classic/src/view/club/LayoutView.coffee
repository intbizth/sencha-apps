Ext.define 'Toro.view.club.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-club-layout'

    controller: 'ctrl-club'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-club-list'
        flex: 1
    ]
