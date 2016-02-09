Ext.define 'Balltoro.view.personal.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-personal-list'

    viewModel:
        type: 'vm-personal'

    bind:
        store: '{personals}'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    selModel:
        checkOnly: no
        selType: 'checkboxmodel'
        showHeaderCheckbox: yes
        pruneRemoved: yes

    listeners:
        selectionchange: 'onSelectionChange'

    reference: 'refPersonalList'
    headerBorders: no
    title: 'บุคคล'

    columns: [
        dataIndex: 'fullname'
        text: 'ชื่อ - นามสกุล'
        flex: 1
        minWidth: 200
    ,
        dataIndex: 'nickname'
        text: 'ชื่อเล่น'
        width: 100
    ,
        dataIndex: 'type'
        text: 'ประเภท'
        width: 150
    ,
        text: 'สโมสร'
        width: 150
        renderer: (v, c, r) ->
            club = r.getClub()
            if club?
                return club.get 'name'
    ,
        text: 'ตำแหน่ง'
        width: 80
        renderer: (v, c, r) ->
            position = r.getPosition()
            if position?
                return position.get 'short_name'
    ]

    dockedItems: [
        defaults:
            scrollable: yes

        xtype: 'toolbar'
        items: [
            xtype: 'button'
            text: 'เพิ่มบุคคล'
            iconCls: 'fa fa-pencil'
            ui: 'default-toolbar'
            handler: 'onAddNew'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refEditButton'
            text: 'แก้ไขบุคคล'
            iconCls: 'fa fa-pencil-square-o '
            ui: 'default-toolbar'
            disabled: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            xtype: 'button'
            reference: 'refDeleteButton'
            text: 'ลบบุคคล'
            iconCls: 'fa fa-minus-square'
            ui: 'default-toolbar'
            disabled: yes
            handler: 'onDelete'
        ]
    ,
        xtype: 'toolbar'
        border: 1
        items: [
            xtype: 'button'
            reference: 'refClubButton'
            text: 'ข้อมูลสโมสร'
            iconCls: 'fa fa-align-justify'
            ui: 'default-toolbar'
            disabled: yes
            handler: 'onClubClick'
        ,
            '->'
        ,
            xtype: 'searchfield'
            reference: 'refSearchField'
            fieldLabel: 'ค้นหา '
            labelWidth: 50
            bind:
                store: '{personals}'
            margin: '0 10 0 0'
        ,
            xtype: 'button'
            reference: 'refAdvanceSearch'
            text: 'ค้นหาขั้นสูง'
            ui: 'default'
            handler: 'onAdvancedSearch'
        ]
    ]

    bbar:
        xtype: 'pagingtoolbar'
        scrollable: yes
        pageSize: 25
        bind:
            store: '{personals}'
        displayInfo: yes
