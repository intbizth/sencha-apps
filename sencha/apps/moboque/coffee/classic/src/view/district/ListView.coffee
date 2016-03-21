Ext.define 'Moboque.view.district.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-district-list'

    bind:
        store: '{districts}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'รายชื่ออำเภอ'
    reference: 'refDistrictList'
    headerBorders: no

    columns: [
        text: 'ชื่ออำเภอ'
        dataIndex: 'name'
        width: 300
    ,
        text: 'ชื่อจังหวัด'
        flex: 1
        minWidth: 200
        renderer: (v, m, r) ->
            return r.getProvinceName()
    ,
        xtype: 'datecolumn'
        text: 'วันที่สร้าง'
        dataIndex: 'created_at'
        format: 'd-m-Y H:i'
        width: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มข้อมูลอำเภอ'
            xtype: 'button'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            '-'
        ,
            text: 'แก้ไข'
            xtype: 'button'
            reference: 'refEditButton'
            iconCls: 'pencil-square-o '
            bind: widgetRecord: '{refDistrictList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refDistrictList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{districts}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{districts}'
        displayInfo: yes
