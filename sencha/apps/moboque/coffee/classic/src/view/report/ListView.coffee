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
        text: 'ID'
        dataIndex: 'id'
        maxWidth: 120
    ,
        text: 'หัวข้อเหตุฉุกเฉิน'
        dataIndex: 'title'
        flex: 1
        minWidth: 200
    ,
        text: 'Description'
        dataIndex: 'description'
        flex: 1
        minWidth: 200
#    ,
#        text: 'published'
#        dataIndex: 'published'
#        flex: 1
#        maxWidth: 400
#        renderer: (value, metaData, record) ->
#            if value == true then return 'เผยแพร่' else return 'ไม่เผยแพร่'
    ,
        text: 'สถานะ'
        dataIndex: 'state'
        flex: 1
        maxWidth: 600
        renderer: (value, metaData, record) ->
            switch value
                when 'draft' then return 'ร่าง'
                when 'waiting' then return 'รออนุมัติ'
                when 'published' then return '<span style="color:' + '#73b51e' + ';">เผยเพร่</span>'
                when 'rejected' then return 'ยกเลิก'
                when 'approved' then return '<span style="color:' + 'blue' + ';">อนุมัติแล้ว</span>'
                when 'unpublished' then return 'ยกเลิกเผยแพร่'
                else return 'unknown'
    ,
        text: 'ยอดผู้ชม'
        dataIndex: 'unique_viewers'
        flex: 1
        maxWidth: 200
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
            iconCls: 'plus'
            handler: 'onAddNew'
        ,
            '-'
        ,
            text: 'แก้ไข'
            xtype: 'button'
            reference: 'refEditButton'
            iconCls: 'pencil-square-o '
            handler: 'onEdit'
            bind: widgetRecord: '{refReportList.selection}'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
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
