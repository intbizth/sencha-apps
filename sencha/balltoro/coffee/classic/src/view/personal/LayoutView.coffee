Ext.define 'Toro.view.personal.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-personal-layout'

    controller: 'ctrl-personal'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-personal-list'
        flex: 1
    ]
