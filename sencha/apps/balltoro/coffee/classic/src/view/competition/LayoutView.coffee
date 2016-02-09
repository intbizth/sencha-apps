Ext.define 'Balltoro.view.competition.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-competition-layout'

    controller: 'ctrl-competition'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-competition-list'
        flex: 1
    ]
