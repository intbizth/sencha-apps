Ext.define 'Toro.view.profile.LayoutView',
    extend: 'Ext.container.Container'
    xtype: 'ux-profile-layout'

    controller: 'ctrl-profile'
    cls: 'ui-shadow-panel'

    layout:
        type: 'hbox'
        align: 'stretch'

    items: [
        xtype: 'wg-profile-list'
        flex: 1
    ]
