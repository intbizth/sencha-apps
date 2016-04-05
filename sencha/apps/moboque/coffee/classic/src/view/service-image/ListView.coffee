Ext.define 'Moboque.view.service-image.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-service-image-list'

    bind:
        store: '{serviceImages}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'รูปภาพบริการ'
    reference: 'refServiceImageList'
    headerBorders: no

    columns: [
        text: 'คำอธิบายภาพ'
        dataIndex: 'description'
        width: 300
    ,
        text: 'รูปภาพของบริการ'
        width: 300
        renderer: (v, m, r) ->
            return r.getServiceTitle()
    ,
        text: 'ลิงค์รูปภาพ'
        flex: 1
        minWidth: 300
        renderer: (v, m, r) ->
            if image = r.get 'image'
                return image.media.url

            return ''
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มรูปภาพบริการ'
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
            bind: widgetRecord: '{refServiceImageList.selection}'
            aclCheck: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refServiceImageList.selection}'
            aclCheck: yes
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{serviceImages}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{serviceImages}'
        displayInfo: yes
