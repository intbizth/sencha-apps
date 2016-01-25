Ext.define 'Toro.view.club.ListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-club-list'

    viewModel:
        type: 'vm-club-list'

    bind:
        store: '{clubs}'

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

    reference: 'refClubList'
    headerBorders: no
    title: 'สโมสร'

    columns: [
        dataIndex: 'name'
        text: 'ชื่อสโมสร'
        flex: 1
        minWidth: 200
    ,
        dataIndex: 'short_name'
        text: 'ชื่อย่อ'
        width: 100
    ,
        dataIndex: 'signature_name'
        text: 'ฉายา'
        width: 200
    ,
        dataIndex: 'est_year'
        text: 'ปีก่อตั้ง'
        align: 'center'
        width: 100
    ,
        dataIndex: 'stadium_name'
        text: 'สนามแข่งขัน'
        width: 200
    ,
        dataIndex: 'stadium_capacity'
        text: 'ความจุของสนาม'
        width: 100
    ]

    dockedItems: [
        xtype: 'toolbar'
        scrollable: yes
        default:
            xtype: 'button'
            width: 100
        items: [
            text: 'เพิ่มสโมสร'
            iconCls: 'fa fa-pencil'
            handler: 'onAddNew'
        ,
            '-'
        ,
            reference: 'refEditButton'
            text: 'แก้ไขสโมสร'
            iconCls:'fa fa-pencil-square-o '
            disabled: yes
            handler: 'onEdit'
        ,
            '-'
        ,
            reference: 'refDeleteButton'
            text: 'ลบสโมสร'
            iconCls:'fa fa-minus-square'
            disabled: yes
            handler: 'onDelete'
        ]
    ,
        xtype: 'toolbar'
        scrollable: yes
        border: 1
        default:
            xtype: 'button'
            width: 120
        items: [
            reference: 'refPersonalCurrentButton'
            text: 'นักเตะปัจจุบัน'
            iconCls: 'fa fa-align-justify'
            disabled: yes
            handler: 'onPersonalCurrentClick'
        ,
            '-'
        ,
            reference: 'refPersonalPreviousButton'
            text: 'นักเตะก่อนหน้า'
            iconCls: 'fa fa-align-justify'
            disabled: yes
            handler: 'onPersonalPreviousClick'
        ,
            '->'
        ,
            xtype: 'searchfield'
            reference: 'refSearchField'
            fieldLabel: 'ค้นหา'
            labelWidth: 50
            bind:
                store: '{clubs}'
            margin: '0 10 0 0'
        ,
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
            store: '{clubs}'
        displayInfo: yes
