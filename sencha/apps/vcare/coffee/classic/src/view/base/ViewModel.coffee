Ext.define 'Vcare.view.base.ViewModel',
    extend: 'Ext.app.ViewModel'

    createNewUser: -> Ext.create 'Vcare.model.User'

    createNewCustomer: ->
        customer = Ext.create 'Vcare.model.Customer'
        customer.setUser @createNewUser()

        return customer

    isDirty: -> console.warn 'The template method!'
    commit: -> console.warn 'The template method!'
    reject: -> console.warn 'The template method!'
    beforeSubmit: (record, form) ->
    beforeCancel: (record, form) ->
    onSubmitSuccess: (record, form) ->
    onSubmitFailure: (record, form) ->
