Ext.define 'Vcare.view.shipment.Split',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-shipment-split'
    items: [{
        xtype: 'checkbox-selection'
    #    store: 'Companies'
        selType: 'checkboxmodel'
        modal: true
        closable: true
        columns: [
            {
                text: 'Company'
                width: 300
                dataIndex: 'name'
            }
            {
                text: 'Price'
                formatter: 'usMoney'
                dataIndex: 'price'
            }
            {
                text: 'Change'
                dataIndex: 'change'
            }
            {
                text: '% Change'
                dataIndex: 'pctChange'
            }
            {
                text: 'Last Updated'
                width: 120
                formatter: 'date("m/d/Y")'
                dataIndex: 'lastChange'
            }
        ]
        columnLines: true
        height: 300
        frame: true
        title: 'Framed with Checkbox Selection and Horizontal Scrolling'
        initComponent: ->
            @width = 750
            @callParent()
            return
    }]

# ---
# generated by js2coffee 2.1.0
