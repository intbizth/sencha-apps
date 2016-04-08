Ext.define 'Moboque.model.User',
    extend: 'Moboque.model.Base'
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
        name: 'plain_password'
        type: 'string'
    ,
        name: 'enabled'
        type: 'boolean'
    ,
        name: 'roles'
        type: 'auto'
    ,
        name: '_links'
        type: 'auto'
    ,
        name: 'club'
        reference:
            type: 'Club'
            role: 'club'
            associationKey: 'club'
            getterName: 'getClub'
            setterName: 'setClub'
    ,
        name: 'country'
        reference:
            type: 'Country'
            role: 'country'
            associationKey: 'country'
            getterName: 'getCountry'
            setterName: 'setCountry'
    ]

    isEnabled: -> @get('enabled')

    getReadableRoles: ->
        roles = @get('roles') || null
        return roles.join(', ').replace(/ROLE_/g, '') if roles
        return ''

    getProfilePictureUrl: ->
        if link = @get('_links')
            return link.profile_picture.href

        return null
