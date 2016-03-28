Ext.define 'Moboque.view.member.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-member-layout'

    viewModel:
        type: 'vm-member'

    controller: 'ctrl-member'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-member-list'
        flex: 1
    ]
