Ext.define 'Moboque.view.promote_category.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-promote-category-layout'

    viewModel:
        type: 'vm-promote-category'

    controller: 'ctrl-promote-category'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-promote-category-list'
        flex: 1
    ]
