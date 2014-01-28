jQuery ->
  class ServerErrorView extends Backbone.View
    template: Handlebars.compile($("#500-template").html())

    el: "#content"

    initialize: (path)->
      @path = path
      @app = window.app ? {}
      document.title = "CoursesHub - 500"
      @render()

    render:  ->
      $(@el).html @template
        url: @path

      @app.hide_loading()
      @

  @app = window.app ? {}
  @app.ServerErrorView = ServerErrorView

