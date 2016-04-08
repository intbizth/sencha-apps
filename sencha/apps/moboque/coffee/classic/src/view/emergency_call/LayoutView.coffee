Ext.define 'Moboque.view.emergency_call.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-emergency-call-layout'

    viewModel:
        type: 'vm-emergency-call'

    controller: 'ctrl-emergency-call'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-emergency-call-list'
        flex: 1
    ]
