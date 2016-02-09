Ext.define 'Balltoro.view.match.Controller',
    extend: 'Balltoro.view.base.Controller'
    alias: 'controller.ctrl-match'

    init: -> # ..

    # match's form.
    createDialog: (record) ->
        model = @referTo('MatchList').getStore().getModel()
        scope = @
        @dialog = @getView().add
            xtype: 'wg-match-form'
            viewModel:
                getMatchStartTime: -> @get('match').get('start_time')
                setMatchStartTime: (date, time) ->
                    originDate = @getMatchStartTime()
                    date = scope.setDateTimeInRecord(originDate, date, time)

                    @get('match').set 'start_time', date
                    return
                data:
                    title:  if record then 'แก้ไขแมทช์การแข่งขัน' else 'เพิ่มแมทช์การแข่งขัน'
                    match: record || new model()

                formulas:
                    startDate:
                        get: -> @getMatchStartTime()
                        set: (date) -> @setMatchStartTime(date, null)

                    startTime:
                        get: -> @getMatchStartTime()
                        set: (time) -> @setMatchStartTime(null, time)

            listeners:
                beforeclose: (panel, eOpts) =>
                    if record and record.dirty
                        @showConfirmMessage
                            title: 'ข้อมูลมีการเปลี่ยนแปลง'
                            message: 'คุณต้องการออกจากหน้านี้หรือไม่ ?',
                            fn: (pressed) =>
                                if pressed == 'ok'
                                    record.store.rejectChanges()
                                    @dialog.close()

                        return no

        @dialog.show()
        @checkStoreLoadedOnForm()

    getMatchSelection: ->
        list = @referTo 'MatchList'
        return list.getSelection()[0]

    onSelectionChange: (eOpts, selected) ->
        @enabledButtonWithSelection('EditButton', selected.length != 1)
        @enabledButtonWithSelection('EventButton', selected.length != 1)
        @enabledButtonWithSelection('SubstitutionButton', selected.length != 1)
        @enabledButtonWithSelection('RefereeButton', selected.length != 1)
        @enabledButtonWithSelection('PersonalButton', selected.length != 1)
        @enabledButtonWithSelection('DeleteButton', !selected.length)

    # create, update, delete matches.
    onAddNew: -> @createDialog()

    onEdit: ->
        record = @getMatchSelection()
        @createDialog record

    onDelete: ->
        @showConfirmMessage
            title: 'ยืนยันการลบ !'
            message: 'คุณแน่ใจหรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    list = @referTo 'MatchList'
                    records = list.getSelection()
                    store = list.getStore()

                    store.deletes records,
                        callback: (records, store, isSuccess) =>
                        success: (records, store) =>
                            @alertSuccess('ลบแมทช์เรียบร้อยแล้วค่ะ')

                        failure: (records, store) =>
                            @alertFailure('ขออภัย! เกิดปัญหาขณะลบแมทช์ กรุณาลองใหม่อีกครั้งค่ะ')

    onCancel: -> @dialog.close()

    onSubmit: ->
        form = @dialog.down 'form'
        record = @dialog.getViewModel().get 'match'
        store = @referTo('MatchList').getStore()
        isNewRecord = record.phantom

        if form.isValid() and record.dirty
            form.mask('Submitting...')

            record.save
                failure: (rec, o) =>
                    form.unmask()

                    titleMessage = 'ผิดพลาด'
                    errorMessage = 'ขออภัย! เกิดปัญหาขณะจัดการแมทช์ กรุณาลองใหม่อีกครั้งค่ะ'

                    if response = o.error.response
                        # internal server error
                        if response.status == 500
                            titleMessage = response.statusText
                            errorMessage = 'Sorry, something went wrong.'

                        # sf validation error.
                        if response.status == 400
                            obj = Ext.decode response.responseText
                            titleMessage = obj.message

                            Ext.Object.each obj.errors.children, (key, value, item) ->
                                if value.hasOwnProperty('errors')
                                    errorMessage = value.errors[0]

                    @alertFailure
                        title: titleMessage
                        message: errorMessage

                success: (rec, o) =>
                    form.unmask()

                    if isNewRecord
                        store.add rec
                        store.commitChanges()
                        @alertSuccess('เพิ่มแมทช์เรียบร้อยแล้วค่ะ')

                    else
                        @alertSuccess('แก้ไขแมทช์เรียบร้อยแล้วค่ะ')

                    @dialog.close()
        else
            @dialog.close()

    selectTransitions: (button) ->
        record = button.getWidgetRecord()
        transitions = record.get('transitions')

        menus = @createTransitionMenu transitions, (btn) =>
            if transition = btn.value

                # route_api_match_update_transition
                path = record.get('id') + '/' + transition + '/update-state'

                record.manageUpdateRecord record, path,
                    callback: (opts, success, response) =>

                    success: (response, opts) =>
                        record.load
                            failure: =>
                                console.error 'refresh failed try again'

                            success: (record, operation) =>
                                @alertSuccess('จัดการแมทช์เรียบร้อยแล้วค่ะ')

                    failure: (response, opts) =>
                        @alertFailure('ขออภัย! เกิดปัญหาขณะจัดการแมทช์ กรุณาลองใหม่อีกครั้งค่ะ')

        button.setMenu(menus, true)

    selectCompetition: (object, record) ->
        seasonsCombo = @findFieldInForm('season')
        seasonsStore = seasonsCombo.getStore()

        if record?
            seasonsStore.clearFilter yes
            seasonsStore.filter 'competition', record
        else
            seasonsStore.clearFilter()

    selectSeason: (object, record) ->
        if record?
            @loadClubMember(record)

    selectHomeClub: (object, record) ->
        if defaultStadium = record.get 'stadium_name'
            stadiumField = @findFieldInForm('stadium')
            stadiumField.setValue defaultStadium

    onSeasonAfterRender: (field) ->
        record = @dialog.getViewModel().get 'match'

        if season = record.getSeason()
            field.setBind
                visible: season

            if competition = season.getCompetition()
                competitionField = field.up().lookupReference('refCompetition')
                competitionField.setValue(competition.get('id'))

            @loadClubMember(season)

    loadClubMember: (season) ->
        form = @dialog.down 'form'
        count = 0
        form.mask('Loading...')

        Ext.each ['homeClub', 'awayClub'], (name) ->
            clubCombo = form.getForm().findField(name)

            clubCombo.getStore().load
                params:
                    season: season.get 'id'
                callback: (records, operation, isSuccess) ->
                    if isSuccess
                        count++

                    if count == 2
                        form.unmask()

    checkStoreLoadedOnForm: (record) ->
        fieldnames = ['competition', 'season', 'homeFormation', 'awayFormation']

        if record? and record.getHomeClub()
            fieldnames.push 'homeClub'

         if record? and record.getAwayClub()
            fieldnames.push 'awayClub'

        @checkStoreLoaded(record, fieldnames)

    onRefereeClick: ->
        record = @getMatchSelection()

        @dialog = @getView().add
            xtype: 'wg-match-personal-refereelist'
            viewModel:
                data:
                    title: 'จัดการกรรมการ :   ' + record.getHomeClub().get('name') + '  vs  ' + record.getAwayClub().get('name')
                    match: record
            listeners:
                show: =>
                    @dialog.getController().showGridsReferee(record)

        @dialog.show()

    onPersonalClick: ->
        record = @getMatchSelection()

        @dialog = @getView().add
            xtype: 'wg-match-personal'
            viewModel:
                data:
                    title: 'จัดการนักเตะ :   ' + record.getHomeClub().get('name') + '  vs  ' + record.getAwayClub().get('name')
                    match: record

            listeners:
                afterrender: =>
                    @dialog.changeSize()

                resize: =>
                    @dialog.changeSize()

                show: =>
                    @dialog.getController().showGridsPersonal(record)

            changeSize: =>
                box = @getView().getBox()
                @dialog.setBox(box)

        @dialog.show()

    # open card and goal grid.
    onEventClick: ->
        record = @getMatchSelection()

        @dialog = @getView().add
            xtype: 'wg-match-event'
            viewModel:
                data:
                    title: 'เหตุการณ์สำคัญ :   ' + record.getHomeClub().get('name') + '  vs  ' + record.getAwayClub().get('name')
                    match: record

            listeners:
                afterrender: =>
                    @dialog.changeSize()

                resize: =>
                    @dialog.changeSize()

                show: =>
                    @dialog.getController().showGridsEvent(record, 'refMatchCardList', 5)
                    @dialog.getController().showGridsEvent(record, 'refMatchGoalList', 18)

            changeSize: =>
                box = @getView().getBox()
                @dialog.setBox(box)

        @dialog.show()

    # open substitution grid.
    onSubstitutionClick: ->
        record = @getMatchSelection()

        @dialog = @getView().add
            xtype: 'wg-match-event-substitution'
            viewModel:
                data:
                    title: 'เปลี่ยนตัวนักเตะ :   ' + record.getHomeClub().get('name') + '  vs  ' + record.getAwayClub().get('name')
                    match: record

            listeners:
                afterrender: =>
                    @dialog.changeSize()

                resize: =>
                    @dialog.changeSize()

                 show: =>
                    @dialog.getController().showGridsSubstitution(record)
                    @dialog.down('grid').mask('Loading...')

            changeSize: =>
                box = @getView().getBox()
                @dialog.setBox(box)

        @dialog.show()

    onAdvancedSearch: ->
        @dialog = @getView().add
            xtype: 'wg-match-search'

        @dialog.show()

    onSearch: ->
        searchForm = @dialog.down 'form'
        store = @referTo('MatchList').getStore()
        searchFieldValues = searchForm.getForm().getFieldValues(yes)

        if searchFieldValues.hasOwnProperty('enddate')
            searchFieldValues.enddate = Ext.Date.format(searchFieldValues.enddate, 'Y-m-d')

        if !Ext.Object.isEmpty searchFieldValues
            store.load
                params:
                    criteria: searchFieldValues

            @dialog.close()
            return

        @showConfirmMessage
            title: 'ค้นหา'
            message: 'คุณยังไม่ได้ระบุตัวเลือกการค้นหา ออกจากหน้า Advanced Search หรือไม่',
            fn: (pressed) =>
                if pressed == 'ok'
                    @dialog.close()
