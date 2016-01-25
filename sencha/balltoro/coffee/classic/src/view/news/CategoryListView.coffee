Ext.define 'Toro.view.news.CategoryListView',
    extend: 'Toro.view.base.Window'
    alias: 'widget.wg-news-categorylist'

    header: yes
    title: 'จัดการหมวดหมู่ข่าว'

    items: [
        xtype: 'grid'
        headerBorders: no
        header: no
        selModel: 'rowmodel'
        reference: 'refCategoryList'
        width: 400
        height: 400

        store:
            type: 'store-news-categories'
            autoLoad: yes

        plugins: [
            ptype: 'rowediting'
            clicksToEdit: 1
        ]

        listeners:
            edit: 'updateCategoryRecord'
            canceledit: 'cancelEditCategoryRecord'

        viewConfig:
            preserveScrollOnRefresh: yes
            preserveScrollOnReload: yes
            emptyText: 'Empty Data'
            deferEmptyText: no

        columns: [
            dataIndex: 'code'
            text: 'Code'
            width: 160
            editor:
                xtype: 'textfield'
        ,
            dataIndex: 'name'
            text: 'ชื่อ'
            flex: 1
            minWidth: 200
            editor:
                xtype: 'textfield'
        ,
            dataIndex: 'type'
            text: 'ประเภท'
            width: 100
            editor:
                xtype: 'combo'
                forceSelection: yes
                store: [
                    ['news', 'news']
                ,
                    ['scoop', 'scoop']
                ]
        ,
            xtype: 'checkcolumn'
            dataIndex: 'enabled'
            stopSelection: no
            text: 'เปิดใช้งาน'
            width: 100
            editor:
                xtype: 'checkbox'
        ]

        tbar:
            height: 50
            defaults:
                ui: 'default'

            items: [
                xtype: 'button'
                text: 'เพิ่มหมวดหมู่ข่าว'
                handler: 'onAddCategory'
            ,
                xtype: 'button'
                text: 'ลบหมวดหมู่ข่าว'
                handler: 'onDeleteCategoryRecord'
            ]

    ]
