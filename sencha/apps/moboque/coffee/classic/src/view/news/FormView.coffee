Ext.define 'Moboque.view.news.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-news-form'

    requires: 'Ext.form.Translation'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        padding: 10

        defaults:
            xtype: 'textfield'
#            anchor: '100%'
#            labelAlign: 'top'
#            allowBlank: no

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
        ,
            fieldLabel: 'Link'
            emptyText: 'URL Link...'
            bind: '{record.link}'
        ,
            xtype: 'combo'
            fieldLabel: 'ประเภทข่าว'
            displayField: 'title'
            valueField: 'id'
            queryMode: 'local'
            bind:
                store: '{newsCategories}'
                selection: '{newsCategory}'
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
