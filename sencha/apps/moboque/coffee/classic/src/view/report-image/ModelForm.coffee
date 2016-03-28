Ext.define 'Moboque.view.report-image.ModelForm',
    extend: 'Moboque.view.base.ViewModel'
    alias: 'viewmodel.vm-report-image-form'

    stores:
        reportList:
            type: 'store-reports'
            autoLoad: yes
            pageSize: 25

    formulas:
        report:
            get: ->
                @get('record').getReport()

            set: (val) ->
                @get('record').setReport val

        isPhantom:
            get: -> @get('record').phantom

    isDirty: ->
        @get('record').dirty

    commit: ->
        @get('record').commit()

    reject: ->
        @get('record').reject()

        reportId = @get('record').getPrevious('report_id')

        if reportId
            @get('record').setReport @get('reportList').getById(reportId)
            record.commit()
