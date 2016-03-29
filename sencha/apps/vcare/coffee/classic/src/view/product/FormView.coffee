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
        margin: '0 0 10 0'
        floating: no
        defaults:
            iconCls: 'x-fa fa-angle-right'
            iconAlign: 'right'

        items: [
            text: 'Main'
            handler: ->
                console.log @
                console.log 'main'
        ,
            text: 'Attribute'
            handler: ->
                console.log 'attribute'
        ,
            text: 'Categorization'
            handler: ->
                console.log 'categorization'
        ,
            text: 'Image'
            handler: ->
                console.log 'image'
        ,
            text: 'SEO Keyword'
            handler: ->
                console.log 'keyword'
        ]
    ,
        region: 'center'
        xtype: 'container'
        reference: 'refProductForms'
        items: [
            id: 'main'
            html: 'MAIN'
        ,
            id: 'attribute'
            html: 'ATTRIBUTE'
        ,
            id: 'attribute'
            html: 'CATEGORIZATION'
        ,
            id: 'attribute'
            html: 'ATTRIBUTE'
        ,
            id: 'attribute'
            html: 'ATTRIBUTE'
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
