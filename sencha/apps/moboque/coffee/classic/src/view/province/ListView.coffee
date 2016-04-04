Ext.define 'Moboque.view.province.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-province-list'

    bind:
        store: '{provinces}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'รายชื่อจังหวัด'
    reference: 'refProvinceList'
    headerBorders: no

    columns: [
        text: 'ชื่อจังหวัด'
        dataIndex: 'name'
        minWidth: 200
        flex: 1
    ,
        xtype: 'datecolumn'
        text: 'วันที่สร้าง'
        dataIndex: 'created_at'
        format: 'd-m-Y H:i'
        width: 300
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มจังหวัด'
            xtype: 'button'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            '-'
        ,
            text: 'แก้ไข'
            xtype: 'button'
            reference: 'refEditButton'
            iconCls: 'pencil-square-o'
            bind: widgetRecord: '{refProvinceList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refProvinceList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{provinces}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{provinces}'
        displayInfo: yes
