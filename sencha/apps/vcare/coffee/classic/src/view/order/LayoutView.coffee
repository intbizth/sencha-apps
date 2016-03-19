Ext.define 'Vcare.view.order.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-order-layout'

    viewModel:
        type: 'vm-order'

    controller: 'ctrl-order'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-order-list'
        flex: 1
    ]
