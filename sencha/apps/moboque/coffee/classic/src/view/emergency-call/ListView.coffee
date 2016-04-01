Ext.define 'Moboque.view.emergency-call.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-emergency-call-list'

    bind:
        store: '{tels}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'เบอร์โทรฉุกเฉิน'
    reference: 'refEmergencyCallList'
    headerBorders: no

    selModel: 'rowmodel'
    plugins:
        ptype: 'rowediting'
        pluginId: 'rowediting'
        clicksToEdit: 1
        listeners:
            cancelEdit: 'onCancelEdit'
            edit: 'onSubmit'

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่อบริการ'
        dataIndex: 'title'
        width: 200
        editor:
            allowBlank: false
    ,
        text: 'คำอธิบาย'
        dataIndex: 'description'
        flex: 1
        minWidth: 200
        editor:
            allowBlank: false
    ,
        text: 'เบอร์โทรศัพท์'
        dataIndex: 'tel'
        flex: 1
        minWidth: 200
        editor:
            allowBlank: false
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มข้อมูล'
            iconCls: 'plus'
            handler: 'onAddNew'
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
            bind: store: '{tels}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{tels}'
        displayInfo: yes
