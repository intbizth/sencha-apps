Ext.define 'Vcare.view.shipment.Show',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-shipment-show'
    modal: yes
    initComponent: ->
        @items = []
        data = @config.data
        @items.push({
            xtype: 'grid'
            region : 'center'
            title : 'Shipment Units'
            width: 800
            bodyPadding: 10
            reference: 'refShipmentUnitList'
            store: Ext.create 'Ext.data.Store',
                data: data.data.units
                fields: [
                    'id', 'stockable', 'inventory_name', 'inventory_state', 'shipping_state'
                ]

            columns : [
                text: 'ID'
                dataIndex: 'id'
            ,
                text: 'SKU'
                dataIndex: 'stockable'
                renderer: (v,m,r) -> return v.sku
            ,
                text: 'Name'
                dataIndex: 'inventory_name'
                flex: 1
            ,
                text: 'Inventory State'
                dataIndex: 'inventory_state'
                flex: 1
            ,
                text: 'Shipment State'
                dataIndex: 'shipping_state'
                flex: 1

            ]


        })


        @callParent(arguments)
        @center()
# ---
# generated by js2coffee 2.1.0
