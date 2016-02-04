Ext.define 'Toro.view.base.ViewModel',
    extend: 'Ext.app.ViewModel'

    isDirty: -> console.warn 'The template method!'
    commit: -> console.warn 'The template method!'
    reject: -> console.warn 'The template method!'
