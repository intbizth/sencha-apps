Ext.define 'Moboque.view.link.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-link-list'

    bind:
        store: '{links}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'ลิงค์ภายนอก'
    reference: 'refLinkList'
    headerBorders: no

    selModel: 'rowmodel'
    plugins:
        ptype: 'rowediting'
        pluginId: 'rowediting'
        clicksToEdit: 1
        listeners:
            cancelEdit: 'onCancelEdit'
            edit: 'onSubmit'

    columns: [
        text: 'คำอธิบาย'
        dataIndex: 'label'
        width: 200
        editor:
            allowBlank: no
    ,
        text: 'ลิงค์'
        dataIndex: 'url'
        flex: 1
        minWidth: 200
        editor:
            allowBlank: no
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
            bind: widgetRecord: '{refLinkList.selection}'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{links}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{links}'
        displayInfo: yes
