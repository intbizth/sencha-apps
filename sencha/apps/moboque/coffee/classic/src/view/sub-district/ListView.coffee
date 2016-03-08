Ext.define 'Moboque.view.sub-district.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-sub-district-list'

    bind:
        store: '{subDistricts}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'รายชื่อตำบล'
    reference: 'refSubDistrictList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่อตำบล'
        dataIndex: 'name'
        width: 300
    ,
        text: 'ชื่ออำเภอ'
        flex: 1
        minWidth: 200
        renderer: (v, m, r) ->
            return r.getDistrictName()
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
            text: 'เพิ่มข้อมูลตำบล'
            xtype: 'button'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNew'
        ,
            '-'
        ,
            text: 'แก้ไข'
            xtype: 'button'
            reference: 'refEditButton'
            iconCls:'fa fa-pencil-square-o '
            bind:
                disabled: '{!refSubDistrictList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refSubDistrictList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{subDistricts}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{subDistricts}'
        displayInfo: yes