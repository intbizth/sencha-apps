Ext.define 'Moboque.view.service_category.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-service-category-layout'

    viewModel:
        type: 'vm-service-category'

    controller: 'ctrl-service-category'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-service-category-list'
        flex: 1
    ]
