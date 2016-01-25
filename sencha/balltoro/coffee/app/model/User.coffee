Ext.define 'Toro.model.User',
    extend: 'Toro.model.Base'
    api: '/api/users/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'username'
        type: 'string'
    ,
        name: 'displayname'
        type: 'string'
    ,
        name: 'plainPassword'
        mapping: 'password'
        type: 'string'
    ,
        name: 'enabled'
        type: 'boolean'
    ,
        name: '_links'
        type: 'auto'
    ,
        name: 'club'
        reference: 'Club'
    ,
        name: 'country'
        reference: 'Country'
    ,
        name: 'roles'
        type: 'auto'
    ]

    validators:
        username: 'presence'

    getProfilePictureUrl: ->
        if link = @get('_links')
            return link.profile_picture.href

        return null
