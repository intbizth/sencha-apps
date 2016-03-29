Ext.define 'Vcare.view.currency.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-currency-layout'

    viewModel:
        type: 'vm-currency'

    controller: 'ctrl-currency'
    cls: 'ui-shadow-panel'

    layout: 'fit'

    items: [
        xtype: 'wg-currency-list'
    ]
