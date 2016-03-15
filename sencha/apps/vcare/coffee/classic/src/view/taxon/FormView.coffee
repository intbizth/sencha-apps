Ext.define 'Vcare.view.taxon.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-taxon-form'

    requires:
        'Ext.form.Translation'

    bind:
        title: '{title}'

    fullsize: no

    width: 600
    height: 500

    items:
        xtype: 'form'
        padding: 10

        items: [
            xtype: 'textfield'
            fieldLabel: 'Code'
            required: yes
            bind:
                value: '{record.code}'
                disabled: '{!isPhantom}'
            minLength: 3
            maxLength: 8
        ,
            xtype: 'combo'
            queryMode: 'local'
            triggerAction: 'all'
            fieldLabel: 'Parent'
            forceSelection: yes
            required: yes
            editable: no
            displayField: 'name'
            valueField: 'id'
            flex: 1
            bind:
                store: '{parents}'
                selection: '{record.parent}'
                record: '{record}'

            listConfig:
                itemTpl: '<span style="padding-left: {level*20}px">{name}</span>'
                listeners:
                    # don't select itself!
                    beforeitemclick: (list, r) ->
                        cb = list.ownerCmp

                        if cb.record && (cb.record.getId() == r.getId())
                            Ext.Msg.alert('Cannot select.', 'You cannot select itself as parent.')
                            return no
        ,
            xtype: 'fieldtranslation'
            fieldLabel: 'Name'
            itemKey: 'name'
            bind:
                locales: '{locales}'
                locale: '{defaultLocale}'
        ,
            xtype: 'fieldtranslation'
            fieldLabel: 'Permalink'
            itemKey: 'permalink'
            bind:
                locales: '{locales}'
                locale: '{defaultLocale}'
        ,
            xtype: 'fieldtranslation'
            fieldLabel: 'Description'
            itemKey: 'description'
            itemType: 'textarea'
            bind:
                locales: '{locales}'
                locale: '{defaultLocale}'
        ]

        buttons: [
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
