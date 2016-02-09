Ext.define 'Balltoro.view.season.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-season-layout'

    controller: 'ctrl-season'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-season-list'
        flex: 1
    ]
