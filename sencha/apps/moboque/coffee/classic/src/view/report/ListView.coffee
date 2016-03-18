Ext.define 'Moboque.view.report.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-report-list'

    bind:
        store: '{reports}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'กล่องเหตุฉุกเฉิน'
    reference: 'refReportList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'หัวข้อเหตุฉุกเฉิน'
        dataIndex: 'title'
        flex: 1
        minWidth: 200
    ,
        xtype: 'datecolumn'
        text: 'วันที่สร้าง'
        dataIndex: 'created_at'
        width: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มเหตุฉุกเฉิน'
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
            handler: 'onEdit'
            bind: widgetRecord: '{refReportList.selection}'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            handler: 'onDelete'
            bind: widgetRecord: '{refReportList.selection}'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{reports}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{reports}'
        displayInfo: yes
