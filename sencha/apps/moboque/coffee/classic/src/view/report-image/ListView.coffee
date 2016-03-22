Ext.define 'Moboque.view.report-image.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-report-image-list'

    bind:
        store: '{reportsImage}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'รูปภาพ'
    reference: 'refReportImageList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่อรายงาน'
        dataIndex: 'title'
        flex: 1
        minWidth: 120
    ,
        text: 'คำอธิบายภาพ'
        dataIndex: 'description'
        flex: 1
        minWidth: 200
#    ,
#        text: 'ของ รายงาน'
#        width: 300
#        renderer: (value, metaData, record) ->
#            return record.getReportTitle()
#    ,
#        text: 'ลิงค์'
#        width: 300
#        renderer: (value, metaData, record) ->
#            if image = record.get 'image'
#                return image.media.url
#
#            return ''
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มกลุ่ม'
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
            bind: widgetRecord: '{refReportImageList.selection}'
            aclCheck: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refReportImageList.selection}'
            aclCheck: yes
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{reportsImage}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{reportsImage}'
        displayInfo: yes
