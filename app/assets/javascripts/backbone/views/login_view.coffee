jQuery ->
  class LoginView extends Backbone.View
    template: Handlebars.compile($("#login-template").html())

    el: "#content"

    initialize: (url)->
      @path = url.path
      @app = window.app ? {}
      @render()

    render:  ->
      $(@el).html @template
        url: @path

      @app.hide_loading()
      @

  @app = window.app ? {}
  @app.LoginView = LoginView

