class Brsite.Views.UsersNewView extends Backbone.View
 el: '#users'

 template: JST["backbone/templates/users/new"]

 events:
   "submit #new-user": "save"

 initialize: ->
   @render()

 render: ->
   @$el.html @template()

 save: (e) ->
   e.preventDefault()
   e.stopPropagation()
   name = $('#name').val()
   bio = $('#bio').val()
   model = new Brsite.Models.User({name: name, bio: bio})
   @collection.create model,
        success: (user) =>
       @model = user
       window.location.hash = "/#{@model.id}"