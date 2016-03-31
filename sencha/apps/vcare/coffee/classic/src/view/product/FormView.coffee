Ext.define 'Vcare.view.product.FormView',
    extend: 'Ext.form.Panel'
    alias: 'widget.wg-product-form'

    bind:
        title: '{title}'

    reference: 'refProductForm'
    layout: 'border'

    items: [
        region: 'west'
        xtype: 'menu'
        width: 200
        margin: '5 5 0 0'
        border: no
        frame: no
        floating: no
        manageHeight: no
        defaults:
            iconCls: 'x-fa fa-angle-right'
            iconAlign: 'right'
            handler: 'onFormMenuClick'

        items: [
            text: 'Main'
            itemId: 'main'
        ,
            text: 'Attribute'
            itemId: 'attribute'
        ,
            text: 'Categorization'
            itemId: 'categorization'
        ,
            text: 'Image'
            itemId: 'image'
        ,
            text: 'SEO Keyword'
            itemId: 'meta'
        ]
    ,
        region: 'center'
        xtype: 'container'
        reference: 'refFormTabs'
        layout: 'card'
        activeItem: 'main'
        defaults:
            margin: '5 5 0 0'
            anchor : '100%'

        items: [
            itemId: 'main'
            xtype: 'wg-product-form-main'
        ,
            itemId: 'attribute'
            html: 'ATTRIBUTE'
        ,
            itemId: 'categorization'
            xtype: 'wg-product-form-categorization'
        ,
            itemId: 'image'
            html: 'IMAGE'
        ,
            itemId: 'meta'
            xtype: 'wg-product-form-meta'
        ]
    ,
        region: 'south'
        collapsible: no
        layout: 'fit'
        split: no
        bodyPadding: 0

        buttons: [
            text: 'ยกเลิก'
            handler: 'onCancel'
        ,
            text: 'บันทึก'
            handler: 'onSubmit'
            disabled: yes
            formBind: yes
        ]
    ]
