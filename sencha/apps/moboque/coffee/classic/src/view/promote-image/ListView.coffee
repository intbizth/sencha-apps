Ext.define 'Moboque.view.promote-image.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-promote-image-list'

    bind:
        store: '{promotesImage}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'รูปภาพ'
    reference: 'refPromoteImageList'
    headerBorders: no

    listeners:
        selectionchange: ->
            console.log arguments

    columns: [
        text: 'คำอธิบายภาพ'
        dataIndex: 'description'
        flex: 1
        minWidth: 200
    ,
        text: 'หมวดที่อยู่'
        width: 300
        renderer: (value, metaData, record) ->
            return record.getPromoteTitle()
    ,
        text: 'ลิงค์'
        width: 300
        renderer: (value, metaData, record) ->
            if image = record.get 'image'
                return image.media.url


            return ''
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
                disabled: '{!refPromoteImageList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refPromoteImageList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{promotesImage}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{promotesImage}'
        displayInfo: yes
