Ext.define 'Moboque.view.emergency-call.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-emergency-call-list'

    bind:
        store: '{tels}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'เบอร์โทรฉุกเฉิน'
    reference: 'refEmergencyCallList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่อบริการ'
        dataIndex: 'title'
        width: 200
    ,
        text: 'คำอธิบาย'
        dataIndex: 'description'
        flex: 1
        minWidth: 200
    ,
        text: 'เบอร์โทรศัพท์'
        dataIndex: 'tel'
        flex: 1
        minWidth: 200
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มเบอร์ฉุกเฉิน'
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
            handler: 'onEdit'
            bind: widgetRecord: '{refEmergencyCallList.selection}'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            handler: 'onDelete'
            bind: widgetRecord: '{refEmergencyCallList.selection}'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{tels}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{tels}'
        displayInfo: yes
