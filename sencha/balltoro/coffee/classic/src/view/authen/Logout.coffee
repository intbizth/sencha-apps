Ext.define 'Toro.view.authen.Logout',
    extend: 'Ext.window.Window'
    xtype: 'ux-authen-logout',

    requires: [
        'Toro.view.authen.Dialog'
    ],

    header: no
    autoShow: yes
    closable: yes

    items: [
        xtype: 'ux-authen-dialog',
        cls: 'ui-authen-dialog-login'
        autoComplete: yes
        bodyPadding: '20 20'
        header: no
        width: 415

        layout:
            type: 'vbox'
            align: 'stretch'

        defaults:
            margin: '5 0'

        items: [
            xtype: 'label'
            text: 'Sign out'
        ,
            xtype: 'button'
            scale: 'large'
            ui: 'soft-green'
            iconAlign: 'right'
            iconCls: 'x-fa fa-angle-right'
            text: 'Sign out'
            listeners:
                click: 'onLogoutButton'
        ,
            xtype: 'button'
            scale: 'large'
            #ui: 'soft-green'
            iconAlign: 'right'
            iconCls: 'x-fa fa-angle-right'
            text: 'Cancel'
            listeners:
                click: 'onLogoutCancleButton'
        ]
    ]
