Ext.define 'Vcare.view.product.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-product-layout'

    viewModel:
        type: 'vm-product'

    controller: 'ctrl-product'
    cls: 'ui-shadow-panel'

    layout: 'card'
    activeItem: 'list'

    items: [
        xtype: 'wg-product-list'
        id: 'list'
    ]
