Ext.define 'Moboque.view.promote.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-promote-layout'

    viewModel:
        type: 'vm-promote'

    controller: 'ctrl-promote'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-promote-list'
        flex: 1
    ]
