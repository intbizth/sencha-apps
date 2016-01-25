###*
 This class provides the modal Ext.Window support for all Authentication forms.
 It's layout is structured to center any Authentication dialog within it's center,
 and provides a backGround image during such operations.
###
Ext.define 'Toro.view.authen.LockingWindow',
    extend: 'Ext.window.Window'
    xtype: 'ux-locking-window'

    cls: 'ui-authen-locked-window'

    closable: no
    resizable: no
    autoShow: yes
    titleAlign: 'center'
    maximized: yes
    modal: yes
    frameHeader: yes

    layout:
        type: 'vbox'
        align: 'center'
        pack: 'center'
