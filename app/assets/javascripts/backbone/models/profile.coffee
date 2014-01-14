jQuery ->
  class ProfileModel extends Backbone.Model
    paramRoot: 'user'

    defaults:
      id:     null
      name:   null
      phone:  null
      email:  null
      type:   null

    urlRoot: "/profile/"

  @app = window.app ? {}
  @app.ProfileModel = ProfileModel
