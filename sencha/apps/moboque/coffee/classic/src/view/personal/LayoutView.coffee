Ext.define 'Moboque.view.personal.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-personal-layout'

    viewModel:
        type: 'vm-personal'

    controller: 'ctrl-personal'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-personal-list'
        flex: 1
    ]
