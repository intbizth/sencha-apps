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

        items: [
            text: 'Main'
            itemId: 'main'
            handler: 'onFormMenuClick'
        ,
            text: 'Attribute'
            itemId: 'attribute'
            handler: 'onFormMenuClick'
        ,
            text: 'Categorization'
            itemId: 'categorization'
            handler: 'onFormMenuClick'
        ,
            text: 'Image'
            itemId: 'image'
            handler: 'onFormMenuClick'
        ,
            text: 'SEO Keyword'
            itemId: 'meta'
            handler: 'onFormMenuClick'
        ]
    ,
        region: 'center'
        xtype: 'container'
        reference: 'refFormTabs'
        layout: 'card'
        activeItem: 'main'

        items: [
            id: 'main'
            xtype: 'wg-product-form-main'
        ,
            id: 'attribute'
            html: 'ATTRIBUTE'
        ,
            id: 'categorization'
            xtype: 'wg-product-form-categorization'
        ,
            id: 'image'
            html: 'IMAGE'
        ,
            id: 'meta'
            html: 'SEO'
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
