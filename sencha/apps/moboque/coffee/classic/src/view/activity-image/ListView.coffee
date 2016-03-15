Ext.define 'Moboque.view.activity-image.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-activity-image-list'

    bind:
        store: '{activityImages}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'

    title: 'รูปภาพกิจกรรม'
    reference: 'refActivityImageList'
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
        text: 'ภาพของกิจกรรม'
        width: 300
        renderer: (v, m, r) ->
            return r.getActivityTitle()
    # ,
    #     text: 'ลิงค์'
    #     width: 300
    #     renderer: (v, m, r) ->
    #         if image = r.get 'image'
    #             return image.media.url


    #         return ''
    ]

    tbar:
        scrollable: yes
        items: [
            text: 'เพิ่มรูปภาพกิจกรรม'
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
                disabled: '{!refActivityImageList.selection}'
            handler: 'onEdit'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refActivityImageList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind:
                store: '{activityImages}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{activityImages}'
        displayInfo: yes
