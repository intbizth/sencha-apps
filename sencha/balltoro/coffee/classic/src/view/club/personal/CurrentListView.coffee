Ext.define 'Toro.view.club.personal.CurrentListView',
    extend: 'Toro.view.base.Window'
    alias: 'widget.wg-club-personal-currentlist'

    controller: 'ctrl-club-personal'

    bind:
        title: '{title}'

    layout: 'fit'
    modal: yes
    closable: yes

    items: [
        xtype: 'grid'
        reference: 'refPersonalCurrentList'
        flex: 1
        store:
            type: 'store-club-personals'

        selModel: 'rowmodel'
        headerBorders: no
        header: no
        scrollable: yes

        plugins: [
            ptype: 'rowediting'
            clicksToEdit: 1
        ]

        listeners:
            edit: 'updateCurrentRecord'
            canceledit: 'cancelEditRecord'

        viewConfig:
            preserveScrollOnRefresh: yes
            preserveScrollOnReload: yes
            emptyText: 'Empty Data'
            deferEmptyText: no

        columns: [
            dataIndex: 'personal'
            text: 'ชื่อ - นามสกุล'
            flex: 1
            minWidth: 200
            renderer: (v, c, r) ->
                personal = r.getPersonal()
                if personal?
                    return personal.get 'fullname'
            editor:
                xtype: 'combobox'
                forceSelection: yes
                displayField: 'fullname'
                queryMode: 'local'
                valueField: 'id'
                allowBlank: no
                store:
                    type: 'store-personals'
                    autoLoad: yes
                listeners:
                    focus: 'onEditorPersonalFocus'
        ,
            text: 'ตำแหน่ง'
            width: 100
            align: 'center'
            dataIndex: 'position'
            renderer: (v, c, r) ->
                position = r.getPosition()
                if position?
                    return position.get 'short_name'
            editor:
                xtype: 'combobox'
                forceSelection: yes
                displayField: 'short_name'
                queryMode: 'local'
                valueField: 'id'
                allowBlank: no
                store:
                    type: 'store-personal-positions'
                    autoLoad: yes
                listeners:
                    focus: 'onEditorPositionFocus'
        ,
            text: 'ฤดูกาล'
            width: 150
            dataIndex: 'season'
            renderer: (v, c, r) ->
                season = r.getSeason()
                if season?
                    return season.get 'name'
            editor:
                xtype: 'combobox'
                forceSelection: yes
                displayField: 'name'
                queryMode: 'local'
                valueField: 'id'
                allowBlank: no
                store:
                    type: 'store-seasons'
                    autoLoad: yes
                listeners:
                    focus: 'onEditorSeasonFocus'
        ,
            xtype: 'datecolumn'
            dataIndex: 'start_date'
            format: 'd/m/Y'
            text: 'เริ่ม'
            width: 150
            align: 'center'
            editor:
                xtype: 'datefield'
                format: 'd/m/Y'
                allowBlank: no
        ,
            xtype: 'datecolumn'
            dataIndex: 'end_date'
            format: 'd/m/Y'
            text: 'สิ้นสุด'
            width: 150
            align: 'center'
            editor:
                xtype: 'datefield'
                format: 'd/m/Y'
                allowBlank: yes
        ,
            xtype: 'datecolumn'
            dataIndex: 'signed_date'
            format: 'd/m/Y'
            text: 'วันที่เซ็นสัญญา'
            width: 150
            align: 'center'
            editor:
                xtype: 'datefield'
                format: 'd/m/Y'
                allowBlank: no
        ,
            xtype: 'checkcolumn'
            text: 'สถานะผู้เล่น'
            dataIndex: 'is_active'
            width: 100
            stopSelection: no
            editor:
                xtype: 'checkbox'
        ]

        tbar:
            defaults:
                ui: 'default'

            items: [
                xtype: 'button'
                text: 'เพิ่มนักเตะ'
                handler: 'onAddClubPersonal'
            ,
                xtype: 'button'
                text: 'ลบนักเตะ'
                handler: 'onDeleteRecord'
            ]
    ]
