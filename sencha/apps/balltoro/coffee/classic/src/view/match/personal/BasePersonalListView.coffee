Ext.define 'Balltoro.view.match.personal.BasePersonalListView',
    extend: 'Ext.grid.Panel'

    store:
        type: 'store-match-personals'

    headerBorders: no
    header: no
    selModel: 'rowmodel'

    plugins: [
        ptype: 'rowediting'
        clicksToEdit: 1
    ]

    listeners:
        edit: 'updatePersonalRecord'
        canceledit: 'cancelEditRecord'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

    columns: [
        text: 'นักเตะ'
        flex: 1
        minWidth: 200
        dataIndex: 'personal'
        renderer: (value, meta, record) ->
            personal = record.getPersonal()

            if personal?
                return personal.get 'fullname'
        editor:
            xtype: 'combo'
            forceSelection: yes
            displayField: 'fullname'
            # TODO search personal with search text and criterai['club']
            queryMode: 'local'
            valueField: 'id'
            allowBlank: no
            listeners:
                focus: 'onEditorPersonalFocus'
    ,
        dataIndex: 'position'
        text: 'ตำแหน่ง'
        width: 100
        align: 'center'
        renderer: (value, meta, record) ->
            position = record.getPosition()

            if position?
                return position.get 'short_name'
        editor:
            xtype: 'combo'
            forceSelection: yes
            displayField: 'short_name'
            queryMode: 'local'
            valueField: 'id'
            allowBlank: no
            store:
                type: 'store-personal-positions'
                autoLoad: yes
                pageSize: 100
            listeners:
                focus: 'onEditorPositionFocus'
    ,
        xtype: 'checkcolumn'
        text: '11 ตัวจริง'
        dataIndex: 'first_eleven'
        width: 100
        stopSelection: no
        editor:
            xtype: 'checkbox'
    ,
        text: 'เบอร์เสื้อ'
        dataIndex: 'shirt_number'
        width: 100
        align: 'center'
        editor:
            xtype: 'textfield'
            minLength: 1
            maxLength: 2
            allowBlank: yes
            vtype: 'alphanum'
    ,
        xtype: 'checkcolumn'
        text: 'Man of the match'
        dataIndex: 'mom'
        width: 100
        stopSelection: no
        editor:
            xtype: 'checkbox'
    ]
