// Ext.define 'Ext.overrides.form.field.Tag',
//     override: 'Ext.form.field.Tag'

//     XsetValue: (value, add, skipLoad) ->
//         me = this
//         valueStore = me.valueStore
//         valueField = me.valueField
//         unknownValues = []
//         store = me.store
//         record = undefined
//         len = undefined
//         i = undefined
//         valueRecord = undefined
//         cls = undefined
//         params = undefined

//         if Ext.isEmpty(value)
//             value = null

//         if Ext.isString(value) and me.multiSelect
//             value = value.split(me.delimiter)

//         value = Ext.Array.from(value, true)
//         i = 0
//         len = value.length

//         while i < len
//             record = value[i]

//             if !record or !record.isModel
//                 valueRecord = valueStore.findExact(valueField, record)

//                 if valueRecord > -1
//                     value[i] = valueStore.getAt(valueRecord)
//                 else
//                     valueRecord = me.findRecord(valueField, record)

//                     if !valueRecord
//                         if me.forceSelection
//                             unknownValues.push record
//                         else
//                             valueRecord = {}
//                             valueRecord[me.valueField] = record
//                             valueRecord[me.displayField] = record
//                             cls = me.valueStore.getModel()
//                             valueRecord = new cls(valueRecord)

//                     if valueRecord
//                         value[i] = valueRecord
//             i++

//         if !store.isEmptyStore and skipLoad != true and unknownValues.length > 0 and me.queryMode == 'remote'
//             params = {}
//             params[me.valueParam or me.valueField] = unknownValues

//             store.load
//                 params:
//                     criteria: params
//                 callback: ->
//                     if me.itemList
//                         me.itemList.unmask()

//                     me.setValue value, add, true
//                     me.autoSize()
//                     me.lastQuery = false
//                     return

//             return false

//         if !me.multiSelect and value.length > 0
//             i = value.length - 1

//             while i >= 0
//                 if value[i].isModel
//                     value = value[i]
//                     break
//                 i--

//             if Ext.isArray(value)
//                 value = value[value.length - 1]

//         me.callParent [
//             value
//             add
//         ]
