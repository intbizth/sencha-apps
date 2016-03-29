Ext.define 'Vcare.view.shipment.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-shipment-layout'

    viewModel:
        type: 'vm-shipment'

    controller: 'ctrl-shipment'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-shipment-list'
        flex: 1
    ]
