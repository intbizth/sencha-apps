Ext.define 'Moboque.view.gift.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-gift-layout'

    viewModel:
        type: 'vm-gift'

    controller: 'ctrl-gift'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-gift-list'
        flex: 1
    ]
