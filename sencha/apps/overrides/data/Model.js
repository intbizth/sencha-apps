Ext.define('Ext.overrides.data.Model', {
    override: 'Ext.data.Model',

    config: {
        associationWriterIdBased: false,
        translationBaseField: 'translations',
        translationFields: null
    },

    privates: {
        /**
         * Checks if two values are equal, taking into account certain special factors, for
         * example dates.
         * @param {Object} lhs The first value.
         * @param {Object} rhs The second value.
         * @return {Boolean} True if the values are equal.
         * @private
         */
        isEqual: function (lhs, rhs, field) {
            var f;

            if (field) {
                f = field.isField ? field : this.fieldsMap[field];
                if (f) {
                    return f.compare(lhs, rhs) === 0;
                }
            }

            // instanceof is ~10 times faster then Ext.isDate. Values here will not be
            // cross-document objects
            if (lhs instanceof Date && rhs instanceof Date) {
                return lhs.getTime() === rhs.getTime();
            }

            if ((lhs && lhs.isModel) && (rhs && rhs.isModel)) {
                return lhs.getId() === rhs.getId();
            }

            return lhs === rhs;
        }
    },

    getData: function()
    {
        var i, role, roleName, locale, prop, associations, customFields, data = this.callParent(arguments);

        // TODO: only when get data to submit
        if (this.config.associationWriterIdBased) {
            console.warn('DO YOU GET DATA TO SUBMIT?');

            customFields = this.config.associationWriterIdBased;

            if (Ext.isArray(customFields)) {
                associations = {};
                for(i = 0; i < customFields.length; i++) {
                    associations[customFields[i]] = true;
                }
            }

            for (roleName in (associations ? associations : this.associations)) {
                role = this.associations[roleName];

                if (!data[roleName]) {
                    continue;
                }

                if (role.isMany) {
                    data[roleName] = [];
                    role.getAssociatedItem(this).each(function(item) {
                        data[roleName].push(item.getId())
                    });
                } else {
                    data[roleName] = data[roleName][role.cls.idProperty];
                }
            }
        }

        var translations = data[this.config.translationBaseField];

        if (this.config.translationFields && translations) {
            console.warn('DO YOU GET DATA TO SUBMIT?');
            for (locale in translations) {
                if (!locale) {
                    delete translations[locale]
                } else {
                    for (prop in translations[locale]) {
                        if (-1 === Ext.Array.indexOf(this.config.translationFields, prop)) {
                            delete translations[locale][prop];
                        }
                    }
                }
            }
        }

        return data;
    },

    set: function(fieldName, newValue, options) {
        var me = this,
            cls = me.self,
            data = me.data,
            modified = me.modified,
            prevVals = me.previousValues,
            session = me.session,
            single = Ext.isString(fieldName),
            opt = (single ? options : newValue),
            convertOnSet = opt ? opt.convert !== false : me.convertOnSet,
            fieldsMap = me.fieldsMap,
            silent = opt && opt.silent,
            commit = opt && opt.commit,
            updateRefs = !(opt && opt.refs === false) && session,
            // Don't need to do dirty processing with commit, since we'll always
            // end up with nothing modified and not dirty
            dirty = !(opt && opt.dirty === false && !commit),
            modifiedFieldNames = null,
            currentValue, field, idChanged, key, name, oldId, comparator, dep, dependents, i,
            dirtyRank = 0,
            numFields, newId, rankedFields, reference, value, values;
        if (single) {
            values = me._singleProp;
            values[fieldName] = newValue;
        } else {
            values = fieldName;
        }
        if (!(rankedFields = cls.rankedFields)) {
            // On the first edit of a record of this type we need to ensure we have the
            // topo-sort done:
            rankedFields = cls.rankFields();
        }
        numFields = rankedFields.length;
        do {
            for (name in values) {
                value = values[name];
                currentValue = data[name];
                comparator = me;
                field = fieldsMap[name];
                if (field) {
                    if (convertOnSet && field.convert) {
                        value = field.convert(value, me);
                    }
                    comparator = field;
                    reference = field.reference;
                } else {
                    reference = null;
                }

                // ======== MY PATCH ========
                if (reference && reference.cls) {
                    if (currentValue) {
                        if (!currentValue.isModel) {
                            currentValue = me.store.findById(currentValue);
                        } else {
                            currentValue = me[reference.getterName]();
                        }
                    }

                    if ((value && value.isModel) || value === undefined) {
                        //me[reference.setterName](value);
                    } else {

                        if (updateRefs) {
                            session.updateReference(me, field, value, currentValue);
                        }

                        reference.onValueChange(me, session, value, currentValue);

                        // now value should be `model`
                        value = me[reference.getterName]();
                    }
                } else {
                    data[name] = value;
                }
                // ======== END MY PATCH ========

                if (comparator.isEqual(currentValue, value)) {

                    continue;
                }
                /*data[name] = value;*/
                (modifiedFieldNames || (modifiedFieldNames = [])).push(name);
                (prevVals || (me.previousValues = prevVals = {}))[name] = currentValue;
                /*if (reference && reference.cls) {
                    if (updateRefs) {
                        session.updateReference(me, field, value, currentValue);
                    }
                    reference.onValueChange(me, session, value, currentValue);
                }*/
                i = (dependents = field && field.dependents) && dependents.length;
                while (i-- > 0) {
                    (dep = dependents[i]).dirty = true;
                    dirtyRank = dirtyRank ? Math.min(dirtyRank, dep.rank) : dep.rank;
                }
                if (!field || field.persist) {
                    if (modified && modified.hasOwnProperty(name)) {
                        if (!dirty || comparator.isEqual(modified[name], value)) {
                            delete modified[name];
                            me.dirty = -1;
                        }
                    } else if (dirty) {
                        if (!modified) {
                            me.modified = modified = {};
                        }
                        me.dirty = true;
                        modified[name] = currentValue;
                    }
                }
                if (name === me.idField.name) {
                    idChanged = true;
                    oldId = currentValue;
                    newId = value;
                }
            }
            if (!dirtyRank) {
                break;
            }
            field = rankedFields[dirtyRank - 1];
            field.dirty = false;
            if (single) {
                delete values[fieldName];
            } else {
                values = me._singleProp;
                single = true;
            }
            fieldName = field.name;
            values[fieldName] = data[fieldName];
            convertOnSet = true;
            for (; dirtyRank < numFields; ++dirtyRank) {
                if (rankedFields[dirtyRank].dirty) {
                    break;
                }
            }
            if (dirtyRank < numFields) {
                ++dirtyRank;
            } else {
                dirtyRank = 0;
            }
        } while (// new value is the same, so no change...
        // We need the cls to be present because it means the association class is loaded,
        // otherwise it could be pending.
        // we use the field instance to hold the dirty bit to avoid any
        // extra allocations... we'll clear this before we depart. We do
        // this so we can perform the fewest recalculations possible as
        // each dependent field only needs to be recalculated once.
        // The original value in me.modified equals the new value, so
        // the field is no longer modified:
        // fix me.dirty later (still truthy)
        // create only when needed
        // Unless there are dependent fields to process we can break now. This is
        // what will happen for all code pre-dating the depends or simply not
        // using it, so it will add very little overhead when not used.
        // dirtyRank has the minimum rank (a 1-based value) of any dependent field
        // that needs recalculating due to changes above. The way we go about this
        // is to use our helper object for processing single argument invocations
        // to process just this one field. This is because the act of setting it
        // may cause another field to be invalidated, so while we cannot know at
        // this moment all the fields we need to recalculate, we know that only
        // those following this field in rankedFields can possibly be among them.
        // dirtyRank is 1-based
        // clear just this field's dirty state
        // cleanup last value
        // switch over
        // We are now processing a dependent field, so we want to force a
        // convert to occur because it's the only way it will get a value
        // Since dirtyRank is 1-based and refers to the field we need to handle
        // on this pass, we can treat it like an index for a minute and look at
        // the next field on towards the end to find the index of the next dirty
        // field.
        // We found a field after this one marked as dirty so make the index
        // a proper 1-based rank:
        // We did not find any more dirty fields after this one, so clear the
        // dirtyRank and we will perhaps fall out after the next update
        1);
        if (me.dirty < 0) {
            // We might have removed the last modified field, so check to see if there
            // are any modified fields remaining and correct me.dirty:
            me.dirty = false;
            for (key in modified) {
                if (modified.hasOwnProperty(key)) {
                    me.dirty = true;
                    break;
                }
            }
        }
        if (single) {
            // cleanup our reused object for next time... important to do this before
            // we fire any events or call anyone else (like afterEdit)!
            delete values[fieldName];
        }
        ++me.generation;
        if (idChanged) {
            me.id = newId;
            me.callJoined('onIdChanged', [
                oldId,
                newId
            ]);
        }
        if (commit) {
            me.commit(silent, modifiedFieldNames);
        } else if (!silent && !me.editing && modifiedFieldNames) {
            me.callJoined('afterEdit', [
                modifiedFieldNames
            ]);
        }
        return modifiedFieldNames;
    }
});
