Ext.define 'Vcare.view.customer.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-customer-layout'

    viewModel:
        type: 'vm-customer'

    controller: 'ctrl-customer'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-customer-list'
        flex: 1
    ]
