Ext.define 'Toro.view.match.personal.RefereeListView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-match-personal-refereelist'

    controller: 'ctrl-match-personal'

    bind:
        title: '{title}'

    layout:
        type: 'vbox'
        align: 'stretch'

    modal: yes
    closable: yes
    referenceHolder: yes
    width: 400
    height: 300

    items: [
        xtype: 'grid'
        reference: 'refRefereeList'
        flex: 1
        store:
            type: 'store-match-personals'

        selModel: 'rowmodel'
        plugins: [
            ptype: 'rowediting'
            clicksToEdit: 1
        ]

        listeners:
            edit: 'updateRefereeRecord'
            canceledit: 'cancelEditRecord'
            selectionchange: 'onRefereeSelectionChange'

        viewConfig:
            preserveScrollOnRefresh: yes
            preserveScrollOnReload: yes
            emptyText: 'Empty Data'
            deferEmptyText: no

        columns: [
            text: 'รายชื่อกรรมการ'
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
                queryMode: 'remote'
                queryParam: 'search'
                minChars: 1
                valueField: 'id'
                allowBlank: no
                store:
                    type: 'store-referees'
                    pageSize: 100
        ]

        tbar:
            defaults:
                ui: 'default'

            items: [
                xtype: 'button'
                text: 'เพิ่มกรรมการ'
                handler: 'onAddReferee'
            ,
                xtype: 'button'
                text: 'ลบกรรมการ'
                disabled: yes
                handler: 'onDeleteRecord'
                reference: 'refRefereeDeleteButton'
            ]
    ]
