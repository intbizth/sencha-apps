Ext.define 'Moboque.view.personal-department.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-personal-department-layout'

    viewModel:
        type: 'vm-personal-department'

    controller: 'ctrl-personal-department'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-personal-department-list'
        flex: 1
    ]
