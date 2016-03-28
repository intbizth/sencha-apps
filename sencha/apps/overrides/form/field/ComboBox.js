Ext.define('Ext.overrides.form.field.ComboBox', {
    override: 'Ext.form.field.ComboBox',

    config: {
        // for now using for tree-form want to know own record
        // our use-case is: when edit record, the record should no select itself as parent.
        record: null
    },

    /*setSelection: function(rs)
    {
        if (rs && rs.isStore) {
            rs = rs.getData().getRange();
        }

        this.callParent([rs]);
    },*/

    /**
     * @private
     * Sets or adds a value/values
     */
    doSetValue: function(value, /* private for use by addValue */ add) {
        var me = this,
            store = me.getStore(),
            Model = store.getModel(),
            matchedRecords = [],
            valueArray = [],
            autoLoadOnValue = me.autoLoadOnValue,
            isLoaded = store.getCount() > 0 || store.isLoaded(),
            pendingLoad = store.hasPendingLoad(),
            unloaded = autoLoadOnValue && !isLoaded && !pendingLoad,
            forceSelection = me.forceSelection,
            selModel = me.pickerSelectionModel,
            displayIsValue = me.displayField === me.valueField,
            isEmptyStore = store.isEmptyStore,
            lastSelection = me.lastSelection,
            i, len, record, dataObj, valueChanged, key;
        if (add && !me.multiSelect) {
            Ext.raise('Cannot add values to non multiSelect ComboBox');
        }
        // Called while the Store is loading or we don't have the real store bound yet.
        // Ensure it is processed by the onLoad/bindStore.
        // Even if displayField === valueField, we still MUST kick off a load because even though
        // the value may be correct as the raw value, we must still load the store, and
        // upon load, match the value and select a record sop we can publish the *selection* to
        // a ViewModel.
        if (pendingLoad || unloaded || !isLoaded || isEmptyStore) {
            // If they are setting the value to a record instance, we can
            // just add it to the valueCollection and continue with the setValue.
            // We MUST do this before kicking off the load in case the load is synchronous;
            // this.value must be available to the onLoad handler.
            if (!value.isModel) {
                if (add) {
                    me.value = Ext.Array.from(me.value).concat(value);
                } else {
                    me.value = value;
                }
                me.setHiddenValue(me.value);
                // If we know that the display value is the same as the value, then show it.
                // A store load is still scheduled so that the matching record can be published.
                me.setRawValue(displayIsValue ? value : '');
            }
            // Kick off a load. Doesn't matter whether proxy is remote - it needs loading
            // so we can select the correct record for the value.
            //
            // Must do this *after* setting the value above in case the store loads synchronously
            // and fires the load event, and therefore calls onLoad inline.
            //
            // If it is still the default empty store, then the real store must be arriving
            // in a tick through binding. bindStore will call setValueOnData.
            if (unloaded && !isEmptyStore) {
                store.load();
            }
            // If they had set a string value, another setValue call is scheduled in the onLoad handler.
            // If the store is the defauilt empty one, the setValueOnData call will be made in bindStore
            // when the real store arrives.
            if (!value.isModel || isEmptyStore) {
                return me;
            }
        }
        // This method processes multi-values, so ensure value is an array.
        value = add ? Ext.Array.from(me.value).concat(value) : Ext.Array.from(value);
        // Loop through values, matching each from the Store, and collecting matched records
        for (i = 0 , len = value.length; i < len; i++) {
            record = value[i];
            // Set value was a key, look up in the store by that key
            if (!record || !record.isModel) {
                record = me.findRecordByValue(key = record);
                // The value might be in a new record created from an unknown value (if !me.forceSelection).
                // Or it could be a picked record which is filtered out of the main store.
                // Or it could be a setValue(record) passed to an empty store with autoLoadOnValue and aded above.
                if (!record) {
                    record = me.valueCollection.find(me.valueField, key);
                }
            }
            // record was not found, this could happen because
            // store is not loaded or they set a value not in the store
            if (!record) {
                // If we are allowing insertion of values not represented in the Store, then push the value and
                // create a new record to push as a display value for use by the displayTpl
                if (!forceSelection) {
                    // We are allowing added values to create their own records.
                    // Only if the value is not empty.
                    if (!record && value[i]) {
                        dataObj = {};
                        dataObj[me.displayField] = value[i];
                        if (me.valueField && me.displayField !== me.valueField) {
                            dataObj[me.valueField] = value[i];
                        }
                        record = new Model(dataObj);
                    }
                }
                // Else, if valueNotFoundText is defined, display it, otherwise display nothing for this value
                else if (me.valueNotFoundRecord) {
                    record = me.valueNotFoundRecord;
                }
            }
            // record found, select it.
            if (record) {
                matchedRecords.push(record);
                valueArray.push(record.get(me.valueField));
            }
        }
        // If the same set of records are selected, this setValue has been a no-op
        if (lastSelection) {
            len = lastSelection.length;
            if (len === matchedRecords.length) {
                for (i = 0; !valueChanged && i < len; i++) {
                    if (Ext.Array.indexOf(me.lastSelection, matchedRecords[i]) === -1) {
                        valueChanged = true;
                    }
                }
            } else {
                valueChanged = true;
            }
        } else {
            valueChanged = matchedRecords.length;
        }

        // MY PATCH
        // BUG. Combo not display selected value when click edit record
        if (!valueChanged && matchedRecords.length) {
            valueChanged = matchedRecords.length;
        }
        // END MY PATCH

        if (valueChanged) {
            // beginUpdate which means we only want to notify this.onValueCollectionEndUpdate after it's all changed.
            me.suspendEvent('select');
            me.valueCollection.beginUpdate();
            if (matchedRecords.length) {
                selModel.select(matchedRecords, false);
            } else {
                selModel.deselectAll();
            }
            me.valueCollection.endUpdate();
            me.resumeEvent('select');
        } else {
            me.updateValue();
        }
        return me;
    }
});
