Ext.define 'Toro.view.match.event.EventController',
    extend: 'Toro.view.match.SubController'
    alias: 'controller.ctrl-match-event'

    eventRecordsSaved: 0
    eventRecordsCount: 0
    eventRecords: []

    setPlayersStore: (matchRecord) ->
        homePlayersStore = @getPlayersStore('home')
        awayPlayersStore = @getPlayersStore('away')

        homePlayers = matchRecord.get 'home_players'
        awayPlayers = matchRecord.get 'away_players'

        if Ext.isArray(homePlayers) and homePlayers.length
            Ext.each homePlayers, (player) ->
                playerRecond = Ext.create 'Toro.model.Personal',
                    player

                homePlayersStore.add(playerRecond)

        if Ext.isArray(awayPlayers) and awayPlayers.length
            Ext.each awayPlayers, (player) ->
                playerRecond = Ext.create 'Toro.model.Personal',
                    player

                awayPlayersStore.add(playerRecond)

    # use with card, goal, substitution
    setPlayerComboValue: (combo, fieldname, isCustom) ->
        isHomeSide = combo.ownerCt.items.get(2).getValue() == 'home'

        eventList = combo.up 'grid'
        recordSelected = eventList.getSelection()[0]

        if isHomeSide
            combo.setStore(@getPlayersStore('home'))
        else
            combo.setStore(@getPlayersStore('away'))

        if isCustom
            if player = recordSelected.get(fieldname)
                combo.setValue(if Ext.isNumber(player) then player else player.get('id'))
        else
            if player = recordSelected.getPlayer()
                combo.setValue(player.get('id'))

    # use with card, goal
    # ref เช่น 'refMatchCardList'
    # eventType เช่น 5 (eventType.id)
    showGridsEvent: (matchRecord, ref, eventType) ->
        list = @lookupReference(ref)
        listsStore = list.getStore()

        @setPlayersStore(matchRecord)

        listsStore.load
            params:
                criteria:
                    match: matchRecord.get 'id'
                    type: eventType
            callback: (records, operation, success) ->
                if Ext.isArray records
                    Ext.each records, (record) ->
                        record.commit()

    # use with substitution
    showGridsSubstitution: (matchRecord) ->
        @setPlayersStore(matchRecord)

    # use with card, goal
    onEditorPlayerFocus: (combo) ->
        @setPlayerComboValue(combo, 'player', no)

    # use with substitution
    onEditorPlayerOffFocus: (combo) ->
        @setPlayerComboValue(combo, 'playerOff', yes)

    # use with substitution
    onEditorPlayerOnFocus: (combo) ->
        @setPlayerComboValue(combo, 'playerOn', yes)

    ## Add Record Event ##
    onAddCard: ->
        @createNewGridRow('refMatchCardList', 5)

    onAddGoal: ->
        @createNewGridRow('refMatchGoalList', 18)

    # use with card, goal
    # ref เช่น 'refMatchCardList'
    # eventType เช่น eventType.id (card = 5, goal = 18)
    createNewGridRow: (ref, eventType) ->
        eventList = @lookupReference(ref)
        eventsStore = eventList.getStore()
        matchRecord = @getView().getViewModel().get 'match'

        newRecord = Ext.create 'Toro.model.MatchEvent',
            side: 'home'
            minute: 0
            second: 0
            period: 'FirstHaft'
            match: matchRecord.get('id')
            club: matchRecord.getHomeClub().get('id')
            player: null
            type: eventType
            isTouch: if eventType == 18 then yes else no
            _qualifierCard: if eventType == 5 then 'Red' else ''
            _qualifierOwnGoal: no

        eventsStore.insert(eventsStore.getCount(), newRecord)
        eventList.findPlugin('rowediting').startEdit(newRecord)

    # use with substitution
    onAddSubstitution: ->
        substitutionList = @lookupReference('refSubstitutionList')
        substitutionsStore = substitutionList.getStore()

        newRecord = Ext.create 'Toro.model.Substitution',
            playerOff: null
            playerOn: null
            side: 'home'
            minute: 0
            second: 0
            eventOff: null
            eventOn: null

        substitutionsStore.insert(substitutionsStore.getCount(), newRecord)
        substitutionList.findPlugin('rowediting').startEdit(newRecord)

    ## Add Update Event ##
    # use with substitution
    updateEventRecords: (editor, context) ->
        context.grid.mask('submitting...')
        records = context.grid.getGridsEventRecords(context)

        @eventRecordsSaved = 0
        @eventRecordsCount = records.length
        @eventRecords = []

        substitutionRecord = context.record

        Ext.each records, (record) =>
            @doUpdateEventRecord record, context.grid, {
                preSaveEvent: context.view.preSaveEvent
                successSaveEvent: context.view.successSaveEvent
            }, substitutionRecord

    # use with card, goal
    updateEventRecord: (editor, context) ->
        context.grid.mask('submitting...')
        @eventRecordsCount = 1

        @doUpdateEventRecord context.record,  context.grid, {
            preSaveEvent: context.view.preSaveEvent
            successSaveEvent: context.view.successSaveEvent
        }, null

    # use with card, goal, substitution
    doUpdateEventRecord: (record, grid, opts, substitutionRecord) ->
        isHomeSide = record.get('side') == 'home'
        isNewRecord = record.phantom

        # player
        if record.get('player')
            if isHomeSide
                store = @getPlayersStore('home')
            else
                store = @getPlayersStore('away')

            record.setPlayer store.getById(record.get('player'))

        # club
        if isHomeSide
            record.setClub @getHomeClub()
        else
            record.setClub @getAwayClub()

        if opts.preSaveEvent and opts.preSaveEvent(grid, record) is no
            return

       # period
        if record.get('minute') <= 45
            record.set 'period', 'FirstHaft'
        else
            record.set 'period', 'SecondHaft'

        record.save
            success: (record) =>
                @eventRecordsSaved++
                @eventRecords.push record

                if @eventRecordsSaved == @eventRecordsCount
                    records = @eventRecords
                    @eventRecordsSaved = 0
                    @eventRecordsCount = 0
                    @eventRecords = []

                    opts.successSaveEvent(records, isNewRecord, grid, substitutionRecord)
            failure: =>
                if isNewRecord
                    context.store.remove(record)

                grid.unmask()
                @alertFailure('ขออภัยค่ะ! พบปัญหาบางอย่าง กรุณาลองใหม่อีกครั้งค่ะ')

    ## Delete Record Event ##
    onDeleteEventRecord: (button) ->
        @onDeleteRecord(button, 'Event')

    onDeleteSubstitutionRecord: (button) ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    substitutionList = button.up 'grid'
                    substitutionList.mask('Deleting...')

                    recordSelected = substitutionList.getSelection()[0]

                    if !recordSelected
                        @alertFailure('กรุณาเลือก Substitution ที่ต้องการลบก่อนค่ะ')
                        return

                    substitutionOff = recordSelected.get 'eventOff'
                    substitutionOn = recordSelected.get 'eventOn'

                    eventsStore = substitutionList.eventsStore
                    substitutionsStore = substitutionList.getStore()

                    eventsStore.deletes [substitutionOff, substitutionOn],
                        success: (records, store) =>
                            substitutionsStore.remove(recordSelected)
                            substitutionList.unmask()
                            @alertSuccess('ลบ Substitution เรียบร้อยแล้วค่ะ')

                        failure: (records, store) =>
                            substitutionList.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบ Substitution กรุณาลองใหม่อีกครั้งค่ะ')
