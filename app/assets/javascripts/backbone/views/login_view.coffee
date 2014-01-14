jQuery ->
  class LoginView extends Backbone.View
    template: Handlebars.compile($("#login-template").html())

    el: "#content"

    initialize: (url)->
      @path = url.path
      @render()

    render:  ->
      $(@el).html @template
        url: @path
      @

  @app = window.app ? {}
  @app.LoginView = LoginView

