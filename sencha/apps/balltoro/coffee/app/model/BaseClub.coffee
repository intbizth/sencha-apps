Ext.define 'Balltoro.model.BaseClub',
    extend: 'Balltoro.model.Base'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'name'
        type: 'string'
    ,
        name: 'short_name'
        type: 'string'
    ,
        name: 'signature_name'
        type: 'string'
    ,
        name: 'location'
        type: 'string'
    ,
        name: 'est_year'
        type: 'int'
        allowNull: yes
        defaultValue: null
    ,
        name: 'stadium_name'
        type: 'string'
    ,
        name: 'stadium_capacity'
        type: 'int'
    # ,
    #     name: 'standing_position'
    #     type: 'int'
    # ,
    #     name: 'previous_standing_position'
    #     type: 'int'
    ,
        name: 'website'
        type: 'string'
    ,
        name: 'email'
        type: 'string'
    ,
        name: 'logo'
        type: 'auto'
    ,
        name: 'stadium_image'
        type: 'auto'
    ,
        name: 'country'
        reference: 'Country'
    ,
        name: 'clubClass'
        mapping: 'club_class'
        reference: 'ClubClass'
    ]

    validators:
        name: 'presence'
        signatureName: 'presence'
        estYear: 'presence'
        stadiumName: 'presence'
        standing_position: 'presence'
        previous_standing_position: 'presence'
