Ext.define 'Vcare.view.product.form.MetaView',
    extend: 'Ext.form.Panel'
    alias: 'widget.wg-product-form-meta'

    layout:
        type: 'vbox'

    defaults:
        width: '100%'
        labelAlign: 'top'
        margin: '0 5 0 10'

    items: [
        xtype: 'fieldtranslation'
        fieldLabel: 'Meta description'
        itemKey: 'meta_description'
        bind:
            locales: '{locales}'
            locale: '{defaultLocale}'
    ,
        xtype: 'fieldtranslation'
        fieldLabel: 'Meta keyword'
        itemKey: 'meta_keyword'
        bind:
            locales: '{locales}'
            locale: '{defaultLocale}'
    ]
