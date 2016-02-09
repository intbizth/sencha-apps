Ext.define 'Balltoro.view.match.event.SubstitutionListView',
    extend: 'Ext.grid.Panel'
    alias: 'widget.wg-match-event-substitutionlist'

    headerBorders: no
    header: no
    selModel: 'rowmodel'
    reference: 'refSubstitutionList'

    plugins: [
        ptype: 'rowediting'
        clicksToEdit: 1
    ]

    listeners:
        edit: 'updateEventRecords'
        canceledit: 'cancelEditRecord'

    viewConfig:
        preserveScrollOnRefresh: yes
        preserveScrollOnReload: yes
        emptyText: 'Empty Data'
        deferEmptyText: no

        preSaveEvent: (grid, record) ->
            player = record.getPlayer()

            if position = player.get 'position'
                playerPosition = position.short_name
            # else
            #     position = player.getPosition()
            #     playerPosition = position.get 'short_name'

            qualifiers = record.get 'qualifiers'
            jerseyNumber = player.get 'no'

            # for new record
            if !qualifiers.length
                qualifiers = [
                    {qualifier: {id: 45, name: 'JerseyNumber'}, event: null, value: jerseyNumber}
                    {qualifier: {id: 84, name: 'PlayerPosition'}, event: null, value: playerPosition}
                    {qualifier: {id: 87, name: 'RelatedEventId'}, event: null, value: null}
                ]

                record.set 'qualifiers', qualifiers
                return

            # for update record
            substitutionsStore = grid.getStore()

            if record.getType().get('id') == 36
                substitution = substitutionsStore.findRecord('eventOff', record.get('id'))
                relatedEvent = substitution.get 'eventOn'
            else
                substitution = substitutionsStore.findRecord('eventOn', record.get('id'))
                relatedEvent = substitution.get 'eventOff'

            Ext.each qualifiers, (data, index) ->
                if [45, 84, 87].indexOf(data.qualifier) isnt -1
                    if data.qualifier == 87
                        qualifiers[index].value = relatedEvent
                        qualifiers[index].qualifier = {id: 87}

                    if data.qualifier == 84
                        qualifiers[index].value = playerPosition
                        qualifiers[index].qualifier = {id: 84}

                    if data.qualifier == 45
                        qualifiers[index].value = jerseyNumber
                        qualifiers[index].qualifier = {id: 45}
                else
                    qualifiers[index].qualifier = {id: data.qualifier}

            record.set 'qualifiers', qualifiers

        successSaveEvent: (records, isNewRecord, grid, substitutionRecord) ->
            relatedEventOff = null
            relatedEventOn = null
            substitutionsStore = grid.getStore()

            if !isNewRecord
                substitutionRecord.commit()
                grid.unmask()
                return

            # set RelatedEventId ให้กับ qualifiers สำหรับ record ใหม่
            Ext.each records, (record) ->
                if record.getType().get('id') == 36
                    relatedEventOff = record.get 'id'
                else
                    relatedEventOn = record.get 'id'

            if relatedEventOff and relatedEventOn
                substitutionRecord.set 'eventOff', relatedEventOff
                substitutionRecord.set 'eventOn', relatedEventOn
                substitutionRecord.commit()

                updateRelatedEventCount = 0
                eventsStore = grid.eventsStore

                Ext.each records, (record) ->
                    qualifiers = record.get 'qualifiers'

                    Ext.each qualifiers, (data, index) ->
                        if data.qualifier == 87
                            if record.getType().get('id') == 36
                                qualifiers[index].value = relatedEventOn
                            else
                                qualifiers[index].value = relatedEventOff

                    record.save
                        success: (record) ->
                            updateRelatedEventCount++
                            if updateRelatedEventCount == records.length
                                eventsStore.add records
                                grid.unmask()
                                updateRelatedEventCount = 0

                        failure: ->
                            if isNewRecord
                                substitutionsStore.remove(record)

    columns: [
        dataIndex: 'minute'
        text: 'นาที'
        width: 80
        align: 'center'
        editor:
            xtype: 'numberfield'
            minValue: 0
    ,
        dataIndex: 'second'
        text: 'วินาที'
        width: 80
        align: 'center'
        editor:
            xtype: 'numberfield'
            minValue: 0
            maxValue: 59
    ,
        dataIndex: 'side'
        text: 'Side'
        width: 100
        editor:
            xtype: 'combo'
            forceSelection: yes
            store: [
                ['home', 'home']
            ,
                ['away', 'away']
            ]
    ,
        text: 'นักเตะเปลี่ยนออก'
        flex: 1
        minWidth: 200
        dataIndex: 'playerOff'
        renderer: (value, meta, record) ->
            @onPlayerRenderer('playerOff', record)
        editor:
            xtype: 'combo'
            forceSelection: yes
            displayField: 'fullname'
            queryMode: 'local'
            valueField: 'id'
            allowBlank: no
            listeners:
                focus: 'onEditorPlayerOffFocus'
    ,
        text: 'นักเตะเปลี่ยนเข้า'
        flex: 1
        minWidth: 200
        dataIndex: 'playerOn'
        renderer: (value, meta, record) ->
            @onPlayerRenderer('playerOn', record)
        editor:
            xtype: 'combo'
            forceSelection: yes
            displayField: 'fullname'
            queryMode: 'local'
            valueField: 'id'
            allowBlank: no
            listeners:
                focus: 'onEditorPlayerOnFocus'
    ]

    tbar:
        height: 50
        defaults:
            ui: 'default'

        items: [
            xtype: 'button'
            text: 'เพิ่มการเปลี่ยนตัว'
            handler: 'onAddSubstitution'
        ,
            xtype: 'button'
            text: 'ลบการเปลี่ยนตัว'
            handler: 'onDeleteSubstitutionRecord'
        ]

    onPlayerRenderer: (name, record) ->
        player = record.get(name)

        if !player
            return ''

        if Ext.isObject player
            return player.get 'fullname'

        # อาจจะเป็น int หรือ string
        if !Ext.isObject player
            if record.get('side') == 'home'
                playersStore = @up('window').getController().getPlayersStore('home')
            else
                playersStore = @up('window').getController().getPlayersStore('away')

            player = playersStore.getById(player)

            return player.get 'fullname'

    getGridsEventRecords: (context) ->
        subStitutionRecord = context.record
        records = []

        # for create new record
        if subStitutionRecord.phantom
            matchRecord = context.grid.up('window').getViewModel().get 'match'

            substitutionOffRecord = Ext.create 'Balltoro.model.MatchEvent',
                side: subStitutionRecord.get 'side'
                minute: subStitutionRecord.get 'minute'
                second: subStitutionRecord.get 'second'
                period: 'FirstHaft'
                match: matchRecord.get 'id'
                club: matchRecord.getHomeClub().get('id')
                player: subStitutionRecord.get 'playerOff'
                type: 36
                isTouch: no
                _qualifierCard: ''
                _qualifierOwnGoal: no

            records.push substitutionOffRecord

            substitutionOnRecord = Ext.create 'Balltoro.model.MatchEvent',
                side: subStitutionRecord.get 'side'
                minute: subStitutionRecord.get 'minute'
                second: subStitutionRecord.get 'second'
                period: 'FirstHaft'
                match: matchRecord.get 'id'
                club: matchRecord.getHomeClub().get('id')
                player: subStitutionRecord.get 'playerOn'
                type: 37
                isTouch: no
                _qualifierCard: ''
                _qualifierOwnGoal: no

            records.push substitutionOnRecord

            subStitutionRecord.commit()
            return records

        # for update record
        Ext.each @eventsStore.getRange(), (eventRecord) ->
            if eventRecord.get('id') == subStitutionRecord.get('eventOff')
                eventRecord.set
                    player: subStitutionRecord.get 'playerOff'
                    side: subStitutionRecord.get 'side'
                    minute: subStitutionRecord.get 'minute'
                    second: subStitutionRecord.get 'second'

                records.push eventRecord

            if eventRecord.get('id') == subStitutionRecord.get('eventOn')
                eventRecord.set
                    player: subStitutionRecord.get 'playerOn'
                    side: subStitutionRecord.get 'side'
                    minute: subStitutionRecord.get 'minute'
                    second: subStitutionRecord.get 'second'

                records.push eventRecord

        return records

    initComponent: ->
        # new substitution store
        @store = Ext.create 'Ext.data.Store',
            model: 'Balltoro.model.Substitution'

        # event store
        @eventsStore = Ext.create 'Balltoro.store.MatchEvents',
            pageSize: 50

        @eventsStore.load
            params:
                criteria:
                    match: @up('window').getViewModel().get('match').get('id')
                    type: [36, 37]
            callback: (records, operation, isSuccess) =>
                @unmask()

                if records.length
                    Ext.each records, (record) =>
                        type = record.getType()

                        if type.get('id') == 36
                            eventQualifiers = record.get('qualifiers')
                            relatedEventId = null

                            Ext.each eventQualifiers, (qualifier) ->
                                if qualifier.qualifier == 87
                                    relatedEventId = qualifier.value
                                    return no

                            substitutionOffRecord = record
                            substitutionOnRecord = @eventsStore.getById(relatedEventId)

                            substitutionRecord = Ext.create 'Balltoro.model.Substitution',
                                playerOff: substitutionOffRecord.getPlayer()
                                playerOn: substitutionOnRecord.getPlayer()
                                side: substitutionOnRecord.get 'side'
                                minute: substitutionOnRecord.get 'minute'
                                second: substitutionOnRecord.get 'second'
                                eventOff: substitutionOffRecord.get 'id'
                                eventOn: substitutionOnRecord.get 'id'

                            substitutionRecord.commit()
                            @store.add(substitutionRecord)

        @callParent()
