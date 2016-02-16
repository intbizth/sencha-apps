Ext.define 'Moboque.view.event.FormView',
    extend: 'Moboque.view.base.Window'
    alias: 'widget.wg-event-form'

    bind:
        title: '{title}'

    items:
        xtype: 'form'
        layout: 'border'
        referenceHolder: yes

        defaults:
            split: yes
            bodyPadding: 10
