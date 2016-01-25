Ext.define 'Toro.view.club.personal.Controller',
    extend: 'Toro.view.club.Controller'
    alias: 'controller.ctrl-club-personal'

    getPersonalsStore: ->
        return Ext.getStore('personal-store')

    getPositionsStore: ->
        return Ext.getStore('personal-positions-store')

    getSeasonsStore: ->
        return Ext.getStore('season-store')

    showGridsCurrentPersonal: (clubRecord) ->
        currentList = @lookupReference('refPersonalCurrentList')
        currentStore = currentList.getStore()

        currentStore.load
            params:
                criteria:
                    club: clubRecord.get 'id'
                    isActive: yes
            callback: (records, operation, success) ->
                console.log 'personalCurrentStore load => success'

    showGridsPreviousPersonal: (clubRecord) ->
        previousList = @lookupReference('refPersonalPreviousList')
        previousStore = previousList.getStore()

        previousStore.load
            params:
                criteria:
                    club: clubRecord.get 'id'
                    isActive: no
            callback: (records, operation, success) ->
                console.log 'personalPreviousStore load => success'

    onAddClubPersonal: ->
        @createNewGridRow('refPersonalCurrentList')

    createNewGridRow: (ref) ->
        personalList = @lookupReference(ref)
        personalsStore = personalList.getStore()
        clubRecord = @getView().getViewModel().get 'club'

        newRecord = Ext.create 'Toro.model.ClubPersonal',
            club: clubRecord.get('id')
            personal: null
            position: null
            season: null
            start_date: null
            end_date: null
            signed_date: null
            is_active: yes

        personalsStore.insert(personalsStore.getCount(), newRecord)
        personalList.findPlugin('rowediting').startEdit(newRecord)

    onEditorPersonalFocus: (combo) ->
        personalCombo = combo.ownerCt.items.get(0)
        @onEditorComboFocus(personalCombo, combo, combo)

    onEditorPositionFocus: (combo) ->
        positionCombo = combo.ownerCt.items.get(1)
        @onEditorComboFocus(combo, positionCombo, combo)

    onEditorSeasonFocus: (combo) ->
        seasonCombo = combo.ownerCt.items.get(2)
        @onEditorComboFocus(combo, combo, seasonCombo)

    onEditorComboFocus: (personalCombo, positionCombo, seasonCombo) ->
        personalList = personalCombo.up 'grid'
        recordSelected = personalList.getSelection()[0]

        if personal = recordSelected.getPersonal()
            personalCombo.setValue(personal.get('id'))

        if position = recordSelected.getPosition()
            positionCombo.setValue(position.get('id'))

        if season = recordSelected.getSeason()
            seasonCombo.setValue(season.get('id'))

    updateCurrentRecord: (editor, context) ->
        record = context.record
        grid = context.grid
        isNewRecord = record.phantom

        grid.mask('submitting...')

        if record.get('personal')
            record.setPersonal @getPersonalsStore().getById(record.get('personal'))

        if record.get('position')
            record.setPosition @getPositionsStore().getById(record.get('position'))

        if record.get('season')
            record.setSeason @getSeasonsStore().getById(record.get('season'))

        record.save
            success: =>
                grid.unmask()
                @alertSuccess('จัดการข้อมูลนักเตะในสโมสรเรียบร้อยแล้ว')

            failure: ->
                if isNewRecord
                    context.store.remove(record)

                @alertFailure('ขออภัย! เกิดปัญหาขณะลบข้อมูล กรุณาลองใหม่อีกครั้งค่ะ')
                grid.unmask()

    cancelEditRecord: (editor, context) ->
        record = context.record

        if record.phantom
            context.store.remove(record)

    onDeleteRecord: (button) ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = button.up 'grid'
                    list.mask('Deleting...')

                    store = list.getStore()
                    recordSelected = list.getSelection()[0]

                    if !recordSelected
                        @alertFailure('กรุณาเลือกนักเตะ ที่ต้องการลบก่อนค่ะ')
                        return

                    store.deletes [recordSelected],
                        success: (records, store) =>
                            list.unmask()
                            @alertSuccess('ลบนักเตะเรียบร้อยแล้วค่ะ')

                        failure: (records, store) =>
                            list.unmask()
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบนักเตะกรุณาลองใหม่อีกครั้งค่ะ')
