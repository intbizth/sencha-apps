Ext.define 'Toro.view.authen.Login',
    extend: 'Toro.view.authen.LockingWindow'
    xtype: 'ux-authen-login',

    requires: [
        'Toro.view.authen.Dialog'
        'Ext.container.Container'
        'Ext.form.field.Text'
        'Ext.form.field.Checkbox'
        'Ext.button.Button'
    ],

    title: "Let's Log In"

    # Focus the Auth Form to force field focus as well
    defaultFocus: 'ux-authen-dialog'

    viewModel:
        data:
            username: null
            password: null
            rememberMe: no

    items: [
        xtype: 'ux-authen-dialog',
        cls: 'ui-authen-dialog-login'
        defaultButton: 'refLoginButton'
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
            text: 'Sign into your account'
        ,
            xtype: 'textfield'
            cls: 'ui-authen-textbox'
            name: 'username'
            bind: '{username}'
            height: 55
            hideLabel: yes
            allowBlank: no
            emptyText: 'Username'
            triggers:
                glyphed:
                    cls: 'ui-trigger-glyph-noop ui-authen-email-trigger'
        ,
            xtype: 'textfield'
            cls: 'ui-authen-textbox'
            height: 55
            hideLabel: yes
            emptyText: 'Password'
            inputType: 'password'
            name: 'password'
            bind: '{password}'
            allowBlank : no
            triggers:
                glyphed:
                    cls: 'ui-trigger-glyph-noop ui-authen-password-trigger'
        ,
            xtype: 'container'
            layout: 'hbox'
            items: [
                xtype: 'checkboxfield'
                flex : 1
                cls: 'ui-form-panel-font-color ui-authen-remember-me-checkbox'
                height: 30
                bind: '{rememberMe}'
                boxLabel: 'Remember me'
            ,
                xtype: 'box',
                html: '<a href="#authen.password-reset" class="ui-link-forgot-password">Forgot Password ?</a>'
            ]
        ,
            xtype: 'button'
            reference: 'refLoginButton'
            scale: 'large'
            ui: 'soft-green'
            iconAlign: 'right'
            iconCls: 'x-fa fa-angle-right'
            text: 'Login'
            formBind: true
            listeners:
                click: 'onLoginButton'
        ]
    ]

    initComponent: ->
        @addCls 'ui-user-login-register-container'
        @callParent arguments
        return
