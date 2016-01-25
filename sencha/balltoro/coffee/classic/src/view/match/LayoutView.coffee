Ext.define 'Toro.view.match.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-match-layout'

    controller: 'ctrl-match'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-match-list'
        flex: 1
    ]
