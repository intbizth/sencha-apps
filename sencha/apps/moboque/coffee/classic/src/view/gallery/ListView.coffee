Ext.define 'Moboque.view.gallery.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-gallery-list'

    bind:
        store: '{galleries}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    title: 'รูปภาพ'
    reference: 'refGalleryList'
    headerBorders: no

    columns: [
        text: 'ชื่อ'
        dataIndex: 'title'
        width: 250
    ,
        text: 'หมวดหมู่รูปภาพ'
        width: 250
        renderer: (v, m, r) ->
            return r.getGalleryCategoryName()
    ,
        text: 'ลิงค์รูปภาพ'
        minWidth: 250
        flex: 1
        renderer: (v, m, r) ->
            if image = r.get 'image'
                return image.media.url
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
            text: 'เพิ่มรูปภาพ'
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
            bind: widgetRecord: '{refGalleryList.selection}'
            handler: 'onEdit'
            aclCheck: yes
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls: 'trash-o'
            bind: widgetRecord: '{refGalleryList.selection}'
            handler: 'onDelete'
            aclCheck: yes
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{galleries}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{galleries}'
        displayInfo: yes
