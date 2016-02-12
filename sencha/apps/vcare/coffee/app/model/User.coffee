Ext.define 'Vcare.model.User',
    extend: 'Vcare.model.Base'
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
    ]

    validators:
        username: 'presence'

    isEnabled: -> @get('enabled')

    getReadableRoles: ->
        roles = @get('roles') || null
        return roles.join(', ').replace(/ROLE_/g, '') if roles
        return ''

    getProfilePictureUrl: ->
        if link = @get('_links')
            return link.profile_picture.href

        return null
