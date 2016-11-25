Ext.define 'Vcare.view.product.form.AttributeView',
    extend: 'Ext.form.Panel'
    alias: 'widget.wg-product-form-attribute'

    layout:
        type: 'vbox'

    items: [
        xtype: 'button'
        iconCls: 'x-fa fa-pencil-square'
        text: 'Add Attribute'
        scale: 'medium'
        margin: '20 0 0 20'
    ]
