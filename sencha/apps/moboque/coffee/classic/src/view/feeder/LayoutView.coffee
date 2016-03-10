Ext.define 'Moboque.view.feeder.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-feeder-layout'

    viewModel:
        type: 'vm-feeder'

    controller: 'ctrl-feeder'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-feeder-list'
        flex: 1
    ]
