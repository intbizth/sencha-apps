Ext.define 'Balltoro.view.match.personal.PersonalController',
    extend: 'Balltoro.view.match.SubController'
    alias: 'controller.ctrl-match-personal'

    getPositionsStore: ->
        return Ext.getStore('personal-positions-store')

    showGridsPersonal: (matchRecord) ->
        @loadGrids(matchRecord, 'refPersonalHomeList', 'home')
        @loadGrids(matchRecord, 'refPersonalAwayList', 'away')

    loadGrids: (matchRecord, ref, side) ->
        list = @lookupReference(ref)
        listsStore = list.getStore()
        personalsStore = @getPlayersStore(side)

        if side == 'home'
            clubId = @getHomeClub().get('id')
        else
            clubId = @getAwayClub().get('id')

        listsStore.load
            params:
                criteria:
                    match: matchRecord.get 'id'
                    club: clubId
            callback: (records, operation, success) ->
                console.log 'matchPersonalsStore load => success'

        personalsStore.load
            params:
                criteria:
                    club: clubId
            callback: (records, operation, success) ->
                console.log 'homePersonalsStore load => success'

    showGridsReferee: (matchRecord) ->
        refereeList = @lookupReference('refRefereeList')
        refereesStore = refereeList.getStore()

        refereesStore.load
            params:
                criteria:
                    match: matchRecord.get 'id'
                    type: 'referee'
            callback: (records, operation, success) ->
                console.log 'refereesStore load => success'

    onAddHomePersonal: ->
        @createNewGridRow('refPersonalHomeList')

    onAddAwayPersonal: ->
        @createNewGridRow('refPersonalAwayList')

    onAddReferee: ->
        @createNewGridRow('refRefereeList')

    createNewGridRow: (ref) ->
        personalList = @lookupReference(ref)
        personalsStore = personalList.getStore()
        matchRecord = @getView().getViewModel().get 'match'

        newRecord = Ext.create 'Balltoro.model.MatchPersonal',
            match: matchRecord.get('id')
            personal: null
            first_eleven: yes
            mom: no
            shirt_number: null

        personalsStore.insert(personalsStore.getCount(), newRecord)
        personalList.findPlugin('rowediting').startEdit(newRecord)

    onEditorPersonalFocus: (combo) ->
        positionCombo = combo.ownerCt.items.get(1)
        @onEditorComboFocus(combo, positionCombo)

    onEditorPositionFocus: (combo) ->
        personalCombo = combo.ownerCt.items.get(0)
        @onEditorComboFocus(personalCombo, combo)

    onEditorComboFocus: (personalCombo, positionCombo) ->
        personalList = personalCombo.up 'grid'
        recordSelected = personalList.getSelection()[0]
        isHomeSide = personalList.getItemId() == 'home'

        if isHomeSide
            personalCombo.setStore(@getPlayersStore('home'))
        else
            personalCombo.setStore(@getPlayersStore('away'))

        if personal = recordSelected.getPersonal()
            personalCombo.setValue(personal.get('id'))

        if position = recordSelected.getPosition()
            positionCombo.setValue(position.get('id'))

    updatePersonalRecord: (editor, context) ->
        record = context.record
        grid = context.grid
        isHomeSide = grid.getItemId() == 'home'
        isNewRecord = record.phantom

        grid.mask('submitting...')

        # personal
        if record.get('personal')
            if isHomeSide
                store = @getPlayersStore('home')
            else
                store = @getPlayersStore('away')

            # TODO check store limit
            record.setPersonal store.getById(record.get('personal'))

        # position
        if record.get('position')
            record.setPosition @getPositionsStore().getById(record.get('position'))

        record.save
            success: =>
                @alertSuccess('บันทึกข้อมูลนักเตะเรียบร้อยแล้วค่ะ')
                grid.unmask()
            failure: =>
                if isNewRecord
                    context.store.remove(record)

                @alertFailure('ขออภัย! เกิดปัญหาขณะบันทึกข้อมูลนักเตะ กรุณาลองใหม่อีกครั้งค่ะ')
                grid.unmask()

    updateRefereeRecord: (editor, context) ->
        record = context.record
        grid = context.grid
        isNewRecord = record.phantom
        store = context.column.getEditor().getStore()

        grid.mask('submitting...')

        # # personal
        if record.get('personal')
            record.setPersonal store.getById(record.get('personal'))

        record.save
            success: =>
                @alertSuccess('บันทึกข้อมูลกรรมการเรียบร้อยแล้วค่ะ')
                grid.unmask()
            failure: =>
                if isNewRecord
                    context.store.remove(record)

                @alertFailure('ขออภัย! เกิดปัญหาขณะบันทึกข้อมูลกรรมการ กรุณาลองใหม่อีกครั้งค่ะ')
                grid.unmask()

    onDeletePersonalRecord: (button) ->
        @onDeleteRecord(button, 'บุคคล')

    onRefereeSelectionChange: (eOpts, selected) ->
        refereeDeleteButton = @lookupReference('refRefereeDeleteButton')
        refereeDeleteButton.setDisabled(selected.length != 1)
