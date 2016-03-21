Ext.define 'Moboque.view.base.ViewModel',
    extend: 'Ext.app.ViewModel'

    isDirty: -> console.warn 'The template method!'
    commit: -> console.warn 'The template method!'
    reject: -> console.warn 'The template method!'
    beforeSubmit: (record, form) ->
    beforeCancel: (record, form) ->
    onSubmitSuccess: (record, form) ->
    onSubmitFailure: (record, form) ->
    setDateTimeInRecord: (originDate, date, time) ->
        if date?
            _date = Ext.Date.format(date, 'Y-m-d')

            if originDate?
                _time = Ext.Date.format(originDate, 'H:i:s')
            else
                _time = '00:00:00'

            date = Ext.Date.parse(_date + ' ' + _time, 'Y-m-d H:i:s')
        else
            date = originDate

        if time?
            date = Ext.Date.format(date, 'Y-m-d')
            dateTime = date + ' ' + Ext.Date.format(time, 'H:i:s')
            date = Ext.Date.parse dateTime, 'Y-m-d H:i:s'

        return date
