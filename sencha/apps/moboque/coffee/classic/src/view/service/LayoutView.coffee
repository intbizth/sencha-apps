Ext.define 'Moboque.view.service.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-service-layout'

    viewModel:
        type: 'vm-service'

    controller: 'ctrl-service'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-service-list'
        flex: 1
    ]
