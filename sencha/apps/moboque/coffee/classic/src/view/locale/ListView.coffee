Ext.define 'Moboque.view.locale.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-locale-list'

    bind:
        store: '{locales}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'ภาษาและการแปล'
    reference: 'refLocaleList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'ชื่อกลุ่ม'
        dataIndex: 'code'
        width: 300
    ,
        xtype: 'datecolumn'
        text: 'วันที่สร้าง'
        dataIndex: 'created_at'
        format: 'd-m-Y H:i'
        width: 300
    ,
        text: 'enabled'
        maxWidth: 300
        filter: 'boolean'
        flex: 1
#        renderer: (value, metaData, record) ->
#            return record.getLocaleCategoryName()
#        xtype: 'widgetcolumn',
#        widget: {
#            xtype: 'combo',
#            store: [
#                'Local',
#                'Remote'
#            ]
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มกลุ่ม'
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
                disabled: '{!refLocaleList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refLocaleList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{locales}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{locales}'
        displayInfo: yes
