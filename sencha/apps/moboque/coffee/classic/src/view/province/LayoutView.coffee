Ext.define 'Moboque.view.province.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-province-layout'

    viewModel:
        type: 'vm-province'

    controller: 'ctrl-province'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-province-list'
        flex: 1
    ]
