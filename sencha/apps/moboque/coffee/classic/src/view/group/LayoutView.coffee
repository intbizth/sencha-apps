Ext.define 'Moboque.view.group.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-group-layout'

    viewModel:
        type: 'vm-group'

    controller: 'ctrl-group'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-group-list'
        flex: 1
    ]
