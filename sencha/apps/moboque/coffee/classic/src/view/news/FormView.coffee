Ext.define 'Moboque.view.news.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-news-form'

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
            fieldLabel: 'ชื่อพาดหัวข่าว'
            itemKey: 'title'
            bind:
                locales: '{locales}'
                locale: '{defaultLocale}'
        ,
            xtype: 'fieldtranslation'
            fieldLabel: 'อธิบายย่อ'
            itemKey: 'sub_title'
            itemType: 'textarea'
            bind:
                locales: '{locales}'
                locale: '{defaultLocale}'
        ,
            xtype: 'fieldtranslation'
            fieldLabel: 'รายละเอียดข่าว'
            itemKey: 'detail'
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
