Ext.define 'Moboque.view.sub_district.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-sub-district-layout'

    viewModel:
        type: 'vm-sub-district'

    controller: 'ctrl-sub-district'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-sub-district-list'
        flex: 1
    ]
