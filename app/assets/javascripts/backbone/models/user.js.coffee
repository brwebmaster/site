class Brsite.Models.User extends Backbone.Model
  paramRoot: 'user'


class Brsite.Collections.UsersCollection extends Backbone.Collection
  model: Brsite.Models.User
  url: '/users'
