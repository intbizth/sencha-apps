Ext.define 'Balltoro.model.MatchEvent',
    extend: 'Balltoro.model.Base'
    api: '/api/match-events/'

    fields: [
        name: 'id'
        type: 'int'
    ,
        name: 'side'
        type: 'string'
    ,
        name: 'minute'
        type: 'number'
    ,
        name: 'second'
        type: 'number'
    ,
        name: 'isTouch'
        type: 'boolean'
        critical: yes
        # set ก่อน save
        # card เป็น false เสมอ
        # goal เป็น true เสมอ
    ,
        name: 'period'
        type: 'string'
        # check จากเวลา
        # <= 45 = firstHaft
        # > 45 = secondHaft
    ,
        name: 'outcomeType'
        type: 'string'
        defaultValue: 'Successful'
    ,
        name: 'match'
        reference: 'Match'
    ,
        name: 'club'
        reference: 'Club'
    ,
        name: 'player'
        reference: 'Personal'
    ,
        name: 'type'
        reference: 'MatchEventType'
    ,
        name: 'qualifiers'
        type: 'auto'
        critical: yes
        convert: (qualifiersData, rec) ->
            qualifiers = []

            if qualifiersData?
                Ext.each qualifiersData, (r) ->
                    if r.qualifier.name == 'OwnGoal'
                        rec.set '_qualifierOwnGoal', yes

                    if ['Red', 'Yellow', 'SecondYellow'].indexOf(r.qualifier.name) isnt -1
                        rec.set '_qualifierCard', r.qualifier.name

                    qualifiers.push({
                        event: rec.get 'id'
                        qualifier: r.qualifier.id
                        value: r.value
                    })

            return qualifiers
        serialize: (qualifiersData, rec) ->
            rec.adjustQualifiers(qualifiersData, rec)
    ,
        # bug: field นี้จะเป็น modify record เสมอ
        name: '_qualifierCard'
        type: 'string'
        # TODO remove before send to server
    ,
        name: '_qualifierOwnGoal'
        type: 'boolean'
        defaultValue: null
        # TODO remove before send to server
    ]

    adjustQualifiers: (originQualifiers, rec) ->
        qualifiersStore = Ext.getStore('com-qualifiers-store')
        eventType = rec.getType()

        #### >>> CARD
        # ใน event_type = 'card' จะมี qualifiers แค่ 1 คือ 'Red', 'Yellow' หรือ 'Second' เท่านั้น
        # เมื่อได้ cardSelected (string) แล้วมาหา id มา ใน store
        # เมื่อได้ id ของ cardSelected ให้เอา id มาเชคกับ qualifier.id ของ originQualifiers
            # - หากตรงกัน ไม่ต้องทำอะไร
            # - หากไม่ตรงกัน ให้เปลี่ยนเป็น id ของ cardSelected
            # - หากไม่มี originQualifiers ให้ set เป็น object ไปใหม่ด้วย param: {event, qualifier, value}
        # if originQualifiers.length > 1 ???

        if eventType.get('id') == 5
            # new select
            cardSelected = rec.get '_qualifierCard'
            cardSelectRecord = qualifiersStore.findRecord('name', cardSelected)

            if originQualifiers.length
                Ext.each originQualifiers, (qualifier, index) =>
                    #TODO use name
                    if [85, 90, 107].indexOf(qualifier.qualifier) isnt -1
                        if qualifier.qualifier == cardSelectRecord.get 'id'
                            return originQualifiers
                        else
                            originQualifiers[index].qualifier = cardSelectRecord.get 'id'
                            return originQualifiers

                return originQualifiers

            if !originQualifiers.length
                originQualifiers[0] = {
                    event: null
                    qualifier: cardSelectRecord.get 'id'
                    value: null
                }

                return originQualifiers
        #### <<< CARD

        #### >>> GOAL
        if eventType.get('id') == 18
            goalSelected = rec.get '_qualifierOwnGoal'
            ownGoalSelectRecord = qualifiersStore.findRecord('name', 'OwnGoal')
            originOwnGoal = no
            originOwnGoalIndex = 0

            if originQualifiers.length
                Ext.each originQualifiers, (qualifier, index) ->
                    if qualifier.qualifier == ownGoalSelectRecord.get 'id'
                        # เป็น ownGoal อยู่แล้ว
                        originOwnGoal = yes
                        originOwnGoalIndex = index
                        return no

                # ถ้า เป็น OwnGoal อยู่แล้ว และไม่เปลี่ยนแปลง
                if originOwnGoal and goalSelected
                    return originQualifiers

                # ถ้า เป็น OwnGoal อยู่แล้ว และเปลี่ยนเป็นไม่ใช่ OwnGoal
                if originOwnGoal and !goalSelected
                    originQualifiers.splice(originOwnGoalIndex, 1)

                    if !originQualifiers.length
                        # ถ้าส่งเป็น originQualifiers = null form จะ error validation
                        originQualifiers = ({
                            event: null
                            qualifier: null
                            value: null
                        })

                    return originQualifiers

            # กรณีadd ใหม่
            # 1. add event ใหม่
            # 2. กรณี update event แต่เดิมยังไม่เป็น ownGoal
            if goalSelected
                originQualifiers.push({
                    event: null
                    qualifier: ownGoalSelectRecord.get 'id'
                    value: null
                })

            return originQualifiers

        if eventType.get('id') == 36 or eventType.get('id') == 37
            qualifiers = rec.get 'qualifiers'

            if rec.phantom
                Ext.each qualifiers, (data, index) ->
                    qualifiers[index]['event'] = null

            return qualifiers
