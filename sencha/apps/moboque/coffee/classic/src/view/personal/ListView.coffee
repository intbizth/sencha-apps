Ext.define 'Moboque.view.personal.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-personal-list'

    bind:
        store: '{personals}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'ข้อมูลบุคคล'
    reference: 'refPersonalList'
    headerBorders: no

    columns: [
        text: 'ชื่อ-นามสกุล'
        dataIndex: 'fullname'
        width: 250
    ,
        text: 'ตำแหน่ง'
        dataIndex: 'position'
        width: 250
    ,
        text: 'แผนก'
        flex: 1
        minWidth: 250
        renderer: (v, m, r) ->
            return r.getPersonalDepartmentTitle()
    ,
        xtype: 'datecolumn'
        text: 'สร้างเมื่อ'
        dataIndex: 'created_at'
        format: 'd-m-Y H:i'
        width: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มบุคคล'
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
            bind: widgetRecord: '{refPersonalList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refPersonalList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{personals}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{personals}'
        displayInfo: yes
