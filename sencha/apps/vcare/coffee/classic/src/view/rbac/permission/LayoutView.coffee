Ext.define 'Vcare.view.rbac.permission.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-rbac-permission-layout'
    cls: 'ui-shadow-panel'

    viewModel:
        type: 'vm-rbac-permission'

    controller: 'ctrl-rbac-permission'

    layout: 'fit'

    items: [
        xtype: 'wg-rbac-permission-list'
        flex: 1
    ]
