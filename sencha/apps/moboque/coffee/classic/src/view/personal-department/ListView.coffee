Ext.define 'Moboque.view.personal-department.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-personal-department-list'

    bind:
        store: '{personalDepartments}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'แผนก'
    reference: 'refPersonalDepartmentList'
    headerBorders: no

    columns: [
        text: 'ชื่อแผนก'
        dataIndex: 'title'
        flex: 1
        minWidth: 200
    ,
        xtype: 'datecolumn'
        text: 'วันที่เขียน'
        dataIndex: 'created_at'
        format: 'd-m-Y H:i'
        width: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มแผนก'
            xtype: 'button'
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            '-'
        ,
            text: 'แก้ไข'
            xtype: 'button'
            reference: 'refEditButton'
            iconCls:'pencil-square-o '
            bind: widgetRecord: '{refPersonalDepartmentList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'trash-o'
            bind: widgetRecord: '{refPersonalDepartmentList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{personalDepartments}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{personalDepartments}'
        displayInfo: yes
