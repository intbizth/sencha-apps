Ext.define 'Balltoro.view.match.FormView',
    extend: 'Ext.window.Window'
    alias: 'widget.wg-match-form'

    # TODO fix bug in form update with combobox.
    # It's request to server on select records.

    layout: 'fit'
    modal: yes
    closable: yes
    width: 810
    height: 400

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'border'

        defaults:
            split: yes
            bodyPadding: 10

        items: [
            region: 'west'
            collapsible: no
            margin: '5 0 0 0'
            scrollable: yes
            modelValidation: yes
            referenceHolder: yes
            width: 400
            xtype: 'form'

            defaults:
                width: 230
                labelAlign: 'top'

            items: [
                xtype: 'combo'
                name: 'competition'
                fieldLabel: '* ลีก '
                reference: 'refCompetition'
                publishes: 'value'
                allowBlank: no
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                bind: '{match.competition}'
                store:
                    type: 'store-competitions'
                    autoLoad: yes
                listeners:
                    select: 'selectCompetition'
            ,
                xtype: 'combo'
                fieldLabel: '* ฤดูกาล '
                name: 'season'
                reference: 'refSeason'
                allowBlank: no
                displayField: 'name'
                valueField: 'id'
                queryMode: 'local'
                forceSelection: yes
                bind: '{match.season}'
                store:
                    type: 'store-seasons'
                    autoLoad: yes
                listeners:
                    afterrender: 'onSeasonAfterRender'
                    select: 'selectSeason'
            ,
                xtype: 'container'
                layout: 'hbox'
                width: 380
                margin: '10 0 0 0'
                referenceHolder: yes
                defaults:
                    labelAlign: 'top'

                items: [
                    xtype: 'combo'
                    fieldLabel: '* ทีมเจ้าบ้าน '
                    name: 'homeClub'
                    reference: 'refHomeClub'
                    allowBlank: no
                    displayField: 'name'
                    valueField: 'id'
                    width: 230
                    queryMode: 'local'
                    forceSelection: yes
                    bind: '{match.homeClub}'
                    store:
                        type: 'store-clubmembers'
                        autoLoad: yes
                    listeners:
                        select: 'selectHomeClub'
                ,
                    xtype: 'combo'
                    fieldLabel: 'Home Formation'
                    name: 'homeFormation'
                    allowBlank: yes
                    displayField: 'name'
                    valueField: 'id'
                    width: 140
                    margin: '0 0 0 10'
                    queryMode: 'local'
                    bind: '{match.homeFormation}'
                    store:
                        type: 'store-formations'
                        autoLoad: yes
                ]
            ,
                xtype: 'container'
                layout: 'hbox'
                width: 380
                margin: '10 0 0 0'
                defaults:
                    labelAlign: 'top'

                items: [
                    xtype: 'combo'
                    fieldLabel: '* ทีมเยือน '
                    name: 'awayClub'
                    allowBlank: no
                    displayField: 'name'
                    valueField: 'id'
                    width: 230
                    queryMode: 'local'
                    forceSelection: yes
                    bind: '{match.awayClub}'
                    store:
                        type: 'store-clubmembers'
                        autoLoad: yes
                ,
                    xtype: 'combo'
                    fieldLabel: 'Away Formation'
                    name: 'awayFormation'
                    allowBlank: yes
                    displayField: 'name'
                    valueField: 'id'
                    width: 140
                    margin: '0 0 0 10'
                    queryMode: 'local'
                    bind: '{match.awayFormation}'
                    store:
                        type: 'store-formations'
                        autoLoad: yes
                ]
            ]
        ,
            region:'east'
            floatable: no
            margin: '5 0 0 0'
            scrollable: yes
            referenceHolder: yes
            width: 400
            xtype: 'form'

            defaults:
                labelAlign: 'top'

            items: [
                xtype: 'textfield'
                fieldLabel: '* สนามแข่งขัน '
                name: 'stadium'
                bind: '{match.stadium}'
                allowBlank: no
                width: 380
            ,
                xtype: 'combo'
                fieldLabel: '* ประเทศ'
                name: 'country'
                displayField: 'name'
                valueField: 'id'
                width: 230
                queryMode: 'local'
                forceSelection: yes
                allowBlank: no
                bind: '{match.country}'
                store:
                    type: 'store-countries'
                    autoLoad: yes
                    pageSize: 100
            ,
                xtype: 'container'
                layout: 'hbox'
                width: 380
                defaults:
                    labelAlign: 'top'

                items: [
                    xtype: 'datefield'
                    fieldLabel: 'วันเริ่มการแข่งขัน'
                    submitFormat: 'Y-m-d'
                    format: 'Y-m-d'
                    allowBlank: no
                    bind: '{startDate}'
                    width: 230
                ,
                    xtype: 'timefield'
                    fieldLabel: 'เวลาเริ่มการแข่งขัน'
                    format: 'H:i'
                    allowBlank: yes
                    bind: '{startTime}'
                    width: 140
                    margin: '0 0 0 10'
                ]
            ,
                xtype: 'numberfield'
                fieldLabel: 'Handicap '
                width: 100
                margin: '10 0 0 0'
                bind: '{match.handicap}'
            ]
        ,
            region: 'south'
            collapsible: no
            layout: 'fit'
            split: no
            bodyPadding: 0
            buttons: [
                text: 'ยกเลิก'
                handler: 'onCancel'
            ,
                text: 'บันทึก'
                handler: 'onSubmit'
                disabled: yes
                formBind: yes
            ]
        ]
