Ext.define 'Moboque.view.travel.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-travel-layout'

    viewModel:
        type: 'vm-travel'

    controller: 'ctrl-travel'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-travel-list'
        flex: 1
    ]
