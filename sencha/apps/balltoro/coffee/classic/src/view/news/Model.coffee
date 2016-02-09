Ext.define 'Balltoro.view.news.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-news'

    stores:
        news:
            type: 'store-news'
            remoteFilter: yes
            autoLoad: yes

        # มีปัญหากับการใช้งานในบางกรณี ที่เรียกใช้ method ซึ่งไม่มี ใน BufferedStore
        # news:
        #     type: 'buffered-store-news'
        #     remoteFilter: yes
        #     autoLoad: yes

        competitions:
            type: 'store-competitions'
            autoLoad: yes

        seasons:
            type: 'store-seasons'
            autoLoad: yes
