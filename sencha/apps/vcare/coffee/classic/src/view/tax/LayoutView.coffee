Ext.define 'Vcare.view.tax.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-tax-layout'

    viewModel:
        type: 'vm-tax'

    controller: 'ctrl-tax'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-tax-list'
        flex: 1
    ]
