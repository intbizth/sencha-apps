Ext.define 'Vcare.view.main.ViewportModel',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-main-viewport'

    data:
        currentView: null
        userDisplayName: 'anon.'

    formulas:
        defaultLocale:
            get: -> Vcare.app.getLocale()
            set: (val) -> Vcare.app.setLocale(val)
