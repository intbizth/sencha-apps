###
 * The main application class. An instance of this class is created by app.js when it
 * calls Ext.application(). This is the ideal place to handle application launch and
 * initialization details.
###
Ext.define 'Toro.Application',
    extend: 'Ext.app.Application'

    # application name
    name: 'Toro'

    # default routing
    defaultToken: 'dashboard'

    authen:
        isLogged: no

    routingToken:
        previous: null
        current: null

    requires: [
        'Toro.*'
    ]

    # global stores
    stores: [
        'Menus'
        'Settings'
    ]

    statics:
        isDebug: no

    launch: (profile) ->

        Ext.create 'Toro.init.Ajax', @, profile
        Ext.create 'Toro.init.OAuth', @, profile

    onAppUpdate: ->
        Ext.Msg.confirm "Application Update", "This application has an update, reload?", (choice) ->
            window.location.reload()  if choice is "yes"
