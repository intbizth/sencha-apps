Ext.define 'Balltoro.model.News',
    extend: 'Balltoro.model.Base'
    api: '/api/news/'
    hasFileUpload: true

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'headline'
        type: 'string'
    ,
        name: 'subhead'
        type: 'string'
    ,
        name: 'description'
        type: 'string'
    ,
        name: 'highlight'
        type: 'string'
    ,
        name: 'content'
        type: 'string'
    ,
        name: 'extra_content'
        type: 'string'
    ,
        name: 'published_date'
        type: 'date'
        dateWriteFormat: 'Y-m-d H:i:s'
    ,
        name: 'published'
        type: 'boolean'
    ,
        name: 'featured'
        type: 'boolean'
    ,
        name: 'hottest'
        type: 'boolean'
    ,
        name: 'credit'
        type: 'string'
    ,
        name: 'credit_url'
        type: 'string'
    ,
        name: 'state'
        type: 'string'
    ,
        name: 'image'
        type: 'auto'
    ,
        name: 'cover'
        type: 'auto'
    ,
        name: 'transitions'
        type: 'auto'
    ,
        name: 'tags'
        type: 'auto'
        critical: yes
        convert: (tags, rec) ->
            # reader
            rec.arrayConverter(@, tags, rec, 'name')
        serialize: (tags, rec) ->
            # writer
            if !tags.length
                return null

            rec.arrayConverter(@, tags, rec, 'name')
    ,
        name: 'season'
        reference: 'Season'
    ,
        name: 'competition'
        reference: 'Competition'
    ,
        name: 'club'
        reference: 'Club'
    ,
        name: 'category'
        reference: 'NewsCategory'
    ,
        name: 'related_clubs'
        type: 'auto'
        critical: yes
        convert: (clubs, rec) ->
            # reader
            rec.arrayConverter(@, clubs, rec, 'id')
        serialize: (clubs, rec) ->
            # writer
            if !clubs.length
                return null

            rec.arrayConverter(@, clubs, rec, 'id')
    ]

    validators:
        headline: 'presence'
        description: 'presence'
        content: 'presence'

    # other method
    getRelatedClubs: -> @getRawData('related_clubs')

    getRelatedClubsLabel: (id) ->
        labels = []
        Ext.each @getRelatedClubs(), (item, i) ->
            labels[i] = item.name

        labels.join ', '
