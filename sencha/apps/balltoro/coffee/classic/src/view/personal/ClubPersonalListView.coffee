Ext.define 'Balltoro.view.personal.ClubPersonalListView',
    extend: 'Balltoro.view.base.Window'
    alias: 'widget.wg-personal-club-list'

    bind:
        title: '{title}'

    layout: 'fit'
    modal: yes
    closable: yes

    items: [
        xtype: 'grid'
        reference: 'refClubPersonalList'
        flex: 1
        store:
            type: 'store-club-personals'

        selModel: 'rowmodel'
        headerBorders: no
        header: no
        scrollable: yes

        viewConfig:
            preserveScrollOnRefresh: yes
            preserveScrollOnReload: yes
            emptyText: 'Empty Data'
            deferEmptyText: no

        columns: [
            text: 'ชื่อ - นามสกุล'
            flex: 1
            minWidth: 200
            renderer: (v, c, r) ->
                personal = r.getPersonal()
                if personal?
                    return personal.get 'fullname'
        ,
            text: 'สโมสร'
            width: 150
            renderer: (v, c, r) ->
                club = r.getClub()
                if club?
                    return club.get 'name'
        ,
            text: 'ตำแหน่ง'
            width: 100
            align: 'center'
            renderer: (v, c, r) ->
                position = r.getPosition()
                if position?
                    return position.get 'short_name'
        ,
            text: 'ฤดูกาล'
            width: 150
            renderer: (v, c, r) ->
                season = r.getSeason()
                if season?
                    return season.get 'name'
        ,
            xtype: 'datecolumn'
            text: 'วันที่เซ็นสัญญา'
            dataIndex: 'start_date'
            format: 'd/m/Y'
            text: 'เริ่ม'
            width: 150
            align: 'center'
        ,
            xtype: 'datecolumn'
            dataIndex: 'end_date'
            format: 'd/m/Y'
            text: 'สิ้นสุด'
            width: 150
            align: 'center'
        ,
            xtype: 'datecolumn'
            dataIndex: 'signed_date'
            format: 'd/m/Y'
            text: 'วันที่เซ็นสัญญา'
            width: 150
            align: 'center'
        ]
    ]
