Ext.define 'Toro.view.profile.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-profile'

    stores:
    	profiles:
            type: 'store-profiles'
            autoLoad: yes

        users:
            type: 'store-users'
            autoLoad: yes
