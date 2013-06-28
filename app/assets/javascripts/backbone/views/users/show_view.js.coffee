class Brsite.Views.UsersShowView extends Backbone.View

  template: JST["backbone/templates/posts/show"]

  el: '#users'

  initialize: ->
    @render()

  render: ->
    @$el.html(@template(@model.toJSON()))
    @