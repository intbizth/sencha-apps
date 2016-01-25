Ext.define 'Toro.view.user.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-user-layout'

    controller: 'ctrl-user'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-user-list'
        margin: '20 20 20 20'
        flex: 1
    ]
