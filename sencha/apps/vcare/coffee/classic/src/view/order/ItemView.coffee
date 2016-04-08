Ext.define 'Vcare.view.order.Show',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-order-show'
    modal: yes

    initComponent: ->
        @items = []
        data = @config.data
        @items.push({
            xtype: 'grid'
            region : 'center'
            title : 'Order Items'
            width: 768
            scrollable: yes
            maxHeight: 768
            reference: 'refOrderItemList'
            store: Ext.create 'Ext.data.Store',
                data: data.getItems().data
                fields: [
                    'id', 'variant', 'product', 'unit_price', 'total', 'quantity'
                ]

            columns : [
                text: 'ID'
                dataIndex: 'id'
            ,
                text: 'SKU'
                dataIndex: 'variant'
                renderer: (v,m,r) -> return v.sku
            ,
                text: 'Name'
                dataIndex: 'product'
                flex: 1
            ,
                text: 'Unit Price'
                dataIndex: 'unit_price'
                flex: 1
            ,
                text: 'Qty'
                dataIndex: 'quantity'
                flex: 1
            ,
                text: 'Total'
                dataIndex: 'total'
                flex: 1

            ]


        })


        @callParent(arguments)
        @center()
# ---
# generated by js2coffee 2.1.0