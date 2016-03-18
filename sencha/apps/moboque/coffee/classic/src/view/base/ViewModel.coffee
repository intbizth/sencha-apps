Ext.define 'Moboque.view.base.ViewModel',
    extend: 'Ext.app.ViewModel'

    isDirty: -> console.warn 'The template method!'
    commit: -> console.warn 'The template method!'
    reject: -> console.warn 'The template method!'
    beforeSubmit: (record, form) ->
    beforeCancel: (record, form) ->
    onSubmitSuccess: (record, form) ->
    onSubmitFailure: (record, form) ->
