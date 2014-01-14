jQuery ->
  class ServerErrorView extends Backbone.View
    template: Handlebars.compile($("#500-template").html())

    el: "#content"

    initialize: (path)->
      @path = path
      document.title = "Courses - 500"
      @render()

    render:  ->
      $(@el).html @template
        url: @path
      @

  @app = window.app ? {}
  @app.ServerErrorView = ServerErrorView

