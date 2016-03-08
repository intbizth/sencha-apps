Ext.define 'Moboque.model.Province',
	extend: 'Moboque.model.Base'
	api: '/api/provinces/'

	fields: [
		name: 'name'
		type: 'string'
	]

	validators:
		name: 'presence'
