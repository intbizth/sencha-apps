Ext.define 'Toro.BufferedStore.News',
    extend: 'Ext.data.BufferedStore'
    model: 'Toro.model.News'

    alias: 'store.buffered-store-news'
    # remoteGroup: yes
    leadingBufferZone: 60
    pageSize: 20
    # autoLoad: yes
