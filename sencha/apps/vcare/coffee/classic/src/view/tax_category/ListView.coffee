Ext.define 'Vcare.view.tax-category.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-tax-category-list'

    bind:
        store: '{taxcategories}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        #deferEmptyText: no

    title: 'หมวดหมู่ภาษี'
    reference: 'refTaxCategoryList'
    headerBorders: no


    columns: [

        text: 'Code'
        dataIndex: 'code'
        width: 80
    ,
        text: 'Name'
        flex: 1
        dataIndex: 'name'

    ,
        text: 'Description'
        flex: 1
        dataIndex: 'description'

    ]
    tbar:
        items: [
            text: 'เพิ่มหมวดหมู่ภาษา'
            xtype: 'button'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNew'
        ,
            '-'
        ,
            text: 'ลบ'
            xtype: 'button'
            reference: 'refDeleteButton'
            iconCls:'fa fa-minus-square'
            bind:
                disabled: '{!refCustomerList.selection}'
            handler: 'onDelete'
        ,
            '->'
        ,
            fieldLabel: 'ค้นหา'
            xtype: 'searchfield'
            reference: 'refSearchField'
            labelWidth: 50
            bind: store: '{locales}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind: store: '{taxcategories}'
        displayInfo: yes
