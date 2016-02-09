Ext.define 'Balltoro.view.match.personal.HomeListView',
    extend: 'Balltoro.view.match.personal.BasePersonalListView'
    alias: 'widget.wg-match-personal-homelist'

    tbar:
        height: 50
        defaults:
            ui: 'default'

        items: [
            xtype: 'title'
            text: 'ทีมเจ้าบ้าน'
        ,
            xtype: 'button'
            text: 'เพิ่มนักเตะ'
            handler: 'onAddHomePersonal'
        ,
            xtype: 'button'
            text: 'ลบนักเตะ'
            handler: 'onDeletePersonalRecord'
        ]
