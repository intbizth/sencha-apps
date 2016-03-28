Ext.define 'Moboque.view.district.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-district-layout'

    viewModel:
        type: 'vm-district'

    controller: 'ctrl-district'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-district-list'
        flex: 1
    ]
