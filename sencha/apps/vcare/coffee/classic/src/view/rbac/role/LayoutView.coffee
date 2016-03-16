Ext.define 'Vcare.view.rbac.role.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-rbac-role-layout'
    cls: 'ui-shadow-panel'

    viewModel:
        type: 'vm-rbac-role'

    controller: 'ctrl-rbac-role'

    layout: 'fit'

    items: [
        xtype: 'wg-rbac-role-list'
        flex: 1
    ]
