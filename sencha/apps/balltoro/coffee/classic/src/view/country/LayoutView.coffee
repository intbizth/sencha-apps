Ext.define 'Balltoro.view.country.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-country-layout'

    controller: 'ctrl-country'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-country-list'
        flex: 1
    ]
