Ext.define 'Moboque.view.travel.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-travel-form'

    requires: 'Ext.form.Translation'

    width: 510
    modal: yes

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        padding: 10

        items: [
            xtype: 'fieldtranslation'
            fieldLabel: 'ชื่อสถานที่'
            itemKey: 'title'
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
