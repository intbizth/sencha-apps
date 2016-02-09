Ext.define 'Balltoro.view.country.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-country-list'

    viewModel:
        type: 'vm-country'

    bind:
        store: '{countries}'

    viewConfig:
        emptyText: 'Empty Data'
        deferEmptyText: no
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes

    selModel:
        checkOnly: no
        selType: 'checkboxmodel'
        showHeaderCheckbox: yes
        pruneRemoved: yes

    listeners:
        selectionchange: 'onSelectionChange'

    reference: 'refCountryList'
    headerBorders: no
    title: 'ประเทศ'

    defaultAlign: 'center'

    columns:
        defaults:
            width: 150
            align: 'center'
        items: [
            dataIndex: 'name'
            text: 'ประเทศ'
            flex: 1
            minWidth: 200
            align: 'left'
        ,
            dataIndex: 'local'
            text: 'รหัสท้องถิ่น'
        ,
            dataIndex: 'code'
            text: 'รหัส'
        ,
            dataIndex: 'type'
            text: 'ประเภท'
        ]

    tbar:
        scrollable: yes
        defaultButtonUI: 'default'
        items: [
            xtype: 'button'
            text: 'เพิ่มประเทศ'
            iconCls: 'fa fa-pencil'
            ui: 'default-toolbar'
            handler: 'onAddNew'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refEditButton'
            text: 'แก้ไขประเทศ'
            iconCls:'fa fa-pencil-square-o '
            ui: 'default-toolbar'
            disabled: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refDeleteButton'
            text: 'ลบประเทศ'
            iconCls:'fa fa-minus-square'
            ui: 'default-toolbar'
            disabled: yes
            handler: 'onDelete'
        ,
            '->'
        ,
            xtype: 'searchfield'
            reference: 'refSearchField'
            fieldLabel: 'ค้นหา '
            labelWidth: 50
            bind:
                store: '{countries}'
            margin: '0 10 0 0'
        ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{countries}'
        displayInfo: yes
