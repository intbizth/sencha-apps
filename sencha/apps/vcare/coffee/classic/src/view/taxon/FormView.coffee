Ext.define 'Vcare.view.taxon.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-taxon-form'

    requires:
        'Ext.form.Translation'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        referenceHolder: yes
        modelValidation: yes
        padding: 10

        #defaults:
        #    labelAlign: 'top'

        items: [
            xtype: 'textfield'
            fieldLabel: 'Code'
            allowBlank: no
            bind: '{record.code}'
            minLength: 3
            maxLength: 6
        ,
            xtype: 'combo'
            queryMode: 'local'
            triggerAction: 'all'
            fieldLabel: 'Parent'
            forceSelection: yes
            editable: no
            displayField: 'name'
            valueField: 'id'
            width: 400
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
                locale: '{currentLocale}'
        ,
            xtype: 'fieldtranslation'
            fieldLabel: 'Permalink'
            itemKey: 'permalink'
            bind:
                locales: '{locales}'
                locale: '{currentLocale}'
        ,
            xtype: 'fieldtranslation'
            fieldLabel: 'Description'
            itemKey: 'description'
            bind:
                locales: '{locales}'
                locale: '{currentLocale}'
        ]

    buttons: [
        text: 'ยกเลิก'
        handler: 'onCancel'
    ,
        text: 'บันทึก'
        handler: 'onSubmit'
        formBind: yes
    ]
