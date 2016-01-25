Ext.define 'Toro.view.user.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-user'

    stores:
    	users:
            type: 'store-users'
            autoLoad: yes
