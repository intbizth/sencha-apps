Ext.define 'Toro.view.competition.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-competition'

    stores:
    	competitions:
    		type: 'store-competitions'
    		autoLoad: yes
