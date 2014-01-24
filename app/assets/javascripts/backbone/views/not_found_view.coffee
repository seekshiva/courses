jQuery ->
  class NotFoundView extends Backbone.View
    template: Handlebars.compile($("#404-template").html())

    el: "#content"

    initialize: (path)->
      @path = path
      document.title = "CoursesHub - 404"
      @render()

    render:  ->
      $(@el).html @template
        url: @path
      @

  @app = window.app ? {}
  @app.NotFoundView = NotFoundView

