class Brsite.Routers.UsersRouter extends Backbone.Router

	initialize: (options) ->
		@users = new Brsite.Collections.UsersCollection()
		@users.reset options.users

	routes:
		"index" 		: "index"
		"new"				: "newUser"
		":id"				: "show"
		":id/edit"	: "edit"
		".*"				: "index"

	index: ->
		@view = new Brsite.Views.UsersIndexView({collection: @users})

	newUser: ->
		@view = new Brsite.Views.UsersNewView({collection: @users})

	show: (id) ->
		user = @users.get(id)
		@view = new Brsite.Views.UsersShowView({model: user})

	edit: (id) ->
		user = @users.get(id)
		@view = new Brsite.Views.UsersEditView({model: user})