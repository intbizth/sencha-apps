Ext.define 'Vcare.view.tax-category.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-tax-categery-layout'

    viewModel:
        type: 'vm-tax-category'

    controller: 'ctrl-tax-category'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-tax-category-list'
        flex: 1
    ]
