###
 * The main application class. An instance of this class is created by app.js when it
 * calls Ext.application(). This is the ideal place to handle application launch and
 * initialization details.
###
Ext.define 'Vcare.Application',
    extend: 'Ext.app.Application'

    # application name
    name: 'Vcare'

    # default routing
    defaultToken: 'dashboard'

    authen:
        user: null

    routingToken:
        previous: null
        current: null

    requires: [
        'Vcare.cfg'
        'Vcare.*'
    ]

    # global stores
    stores: [
        'Menus'
        'Settings'
        'Users'
    ]

    statics:
        IS_DEBUG: no
        events:
            LOGIN_SUCCESS: 'LOGIN_SUCCESS'
            LOGIN_REQUIRED: 'LOGIN_REQUIRED'

    splashscreen: null

    init: ->
        @splashscreen = Ext.getBody().mask('Loading, please stand by ...');

    launch: (profile) ->
        Ext.create 'Vcare.init.Ajax', @, profile
        Ext.create 'Vcare.init.OAuth', @, profile

    onAppUpdate: ->
        Ext.Msg.confirm "Application Update", "This application has an update, reload?", (choice) ->
            window.location.reload()  if choice is "yes"

    logout: ->
        @authen.user = null
        Ext.Msg.confirm "Logout", "Do you want to logout?", (choice) ->
            window.location.href = Vcare.cfg.get 'api.logout'  if choice is "yes"

    expired: ->
        @authen.user = null
        Ext.MessageBox.show
            title: 'Session Expired!'
            msg: "Your logged session was expired, Please login again."
            icon: Ext.MessageBox.ERROR
            buttons: Ext.Msg.OK
            closable: false
            fn: -> window.location.href = Vcare.cfg.get 'api.login'
