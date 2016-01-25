Ext.define 'Toro.view.match.personal.AwayListView',
    extend: 'Toro.view.match.personal.BasePersonalListView'
    alias: 'widget.wg-match-personal-awaylist'

    tbar:
        height: 50
        defaults:
            ui: 'default'

        items: [
            xtype: 'title'
            text: 'ทีมเยือน'
        ,
            xtype: 'button'
            text: 'เพิ่มนักเตะ'
            handler: 'onAddAwayPersonal'
        ,
            xtype: 'button'
            text: 'ลบนักเตะ'
            handler: 'onDeletePersonalRecord'
        ]
