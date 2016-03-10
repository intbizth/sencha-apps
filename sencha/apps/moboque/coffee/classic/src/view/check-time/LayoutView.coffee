Ext.define 'Moboque.view.check-time.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-check-time-layout'

    viewModel:
        type: 'vm-check-time'

    controller: 'ctrl-check-time'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-check-time-list'
        flex: 1
    ]
