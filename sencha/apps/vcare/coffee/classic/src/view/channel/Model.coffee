Ext.define 'Vcare.view.channel.Model',
    extend: 'Ext.app.ViewModel'
    alias: 'viewmodel.vm-channel'

    stores:
        channels:
            type: 'store-channels'
            autoLoad: yes

        currencies:
            type: 'store-currencies'
            autoLoad: yes
            pageSize: no

        taxonomies:
            type: 'store-taxonomies'
            autoLoad: yes
            pageSize: no

        "shipping-methods":
            type: 'store-shipping-methods'
            autoLoad: yes
            pageSize: no

        "payment-methods":
            type: 'store-payment-methods'
            autoLoad: yes
            pageSize: no

    createRecord: (record) ->
        return record if record
        return new (@data.channels.getModel())()
