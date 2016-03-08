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
