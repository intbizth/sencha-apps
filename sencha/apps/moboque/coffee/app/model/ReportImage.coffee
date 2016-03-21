Ext.define 'Moboque.model.ReportImage',
    extend: 'Moboque.model.Base'
    api: '/api/reports/images/'
    hasFileUpload: true

    fields: [
        name: 'report'
        reference:
            type: 'Report'
            role: 'report'
            associationKey: 'report'
            getterName: 'getReport'
            setterName: 'setReport'
    ,
        name: 'image'
        type: 'auto'
    ]

    getReportDescription: ->
        report = @getReport()
        return report.get("description") if report
        return ''

    validators:
        description: 'presence'

    writerTransform: fn: (data) ->
        if data.report
            data.report = data.report.id
        return data
