###*
 * This is the base class for all Authentication related Form dialogs. It optionally
 * enables autoComplete support to any child textfield so that browsers or their plugins
 * may restore/persist username, password and other attributes to/from such forms.
###
Ext.define 'Toro.view.authen.Dialog',
    extend: 'Ext.form.Panel'
    xtype: 'ux-authen-dialog'

    requires: [
        'Toro.view.authen.AuthenController'
        'Ext.form.Panel'
    ]

    controller: 'ctrl-authen'
    #viewModel:
    #    type: 'vm-authen'

    # Seek out the first enabled, focusable, empty textfield when the form is focused
    defaultFocus: 'textfield:focusable:not([hidden]):not([disabled]):not([value])',

    ###*
     * @cfg {Boolean} [autoComplete=false]
     * Enables browser (or Password Managers) support for autoCompletion of User Id and
     * password.
    ###
    autoComplete: no

    initComponent: ->

        if @autoComplete
            # Use standard FORM tag for detection by browser or password tools
            @autoEl = Ext.applyIf(
                @autoEl or {},
                    tag: 'form'
                    name: 'authen-dialog'
                    method: 'post'
            )

        @addCls 'ui-authen-dialog'
        @callParent()

        if @autoComplete
            listen =
                scope: @
                single: yes
                afterrender: 'doAutoComplete'

            Ext.each @query('textfield'), (field) ->
                field.on listen

        return

    doAutoComplete: (target) ->
        if target.inputEl && target.autoComplete != no
            target.inputEl.set autocomplete: 'on'
