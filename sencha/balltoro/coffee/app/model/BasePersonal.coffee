Ext.define 'Toro.model.BasePersonal',
    extend: 'Toro.model.Base'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'firstname'
        type: 'string'
    ,
        name: 'lastname'
        type: 'string'
    ,
        name: 'fullname'
        type: 'string'
    ,
        name: 'nickname'
        type: 'string'
    ,
        name: 'type'
        type: 'string'
    ,
        name: 'birthday'
        type: 'date'
        dateWriteFormat: 'Y-m-d'
    ,
        name: 'no'
        type: 'int'
        allowNull: yes
        defaultValue: null
    ,
        name: 'height'
        type: 'int'
        allowNull: yes
        defaultValue: null
    ,
        name: 'weight'
        type: 'int'
        allowNull: yes
        defaultValue: null
    ,
        name: 'country'
        reference: 'Country'
    ,
        name: 'position'
        reference: 'PersonalPosition'
    ,
        name: 'club'
        reference: 'Club'
    ,
        name: 'image'
        type: 'auto'
    ]

    validators:
        fisname: 'presence'
