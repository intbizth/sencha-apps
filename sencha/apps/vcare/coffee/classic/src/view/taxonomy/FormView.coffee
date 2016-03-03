Ext.define 'Vcare.view.taxonomy.FormView',
    extend: 'Vcare.view.base.Window'
    alias: 'widget.wg-taxonomy-form'

    requires:
        'Ext.form.Translation'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        referenceHolder: yes
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
        ]
