Ext.define 'Vcare.view.payment_method.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-payment-method-layout'

    viewModel:
        type: 'vm-payment-method'

    controller: 'ctrl-payment-method'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-payment-method-list'
        flex: 1
    ]
