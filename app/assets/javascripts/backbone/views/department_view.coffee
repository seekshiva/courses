jQuery ->
  class DepartmentView extends Backbone.View
    template: Handlebars.compile($("#department-template").html())

    el: "#content"

    initialize: (options) ->
      @app = window.app ? {}

      @department = new @app.DepartmentModel({id: options.id})  
      @department.bind "change", @render, @
      @department.bind "destroy", @render, @
      @department.fetch()

    render: =>
      document.title = "Courses - "+@department.attributes.short
      course_listing = []
      for list in @department.attributes.course_listing
        list.course_list.sort((a,b)-> return a.code>b.code)
        course_listing.push list
      @department.attributes.course_listing = course_listing
      $(@el).html @template
        dept: @department.attributes
      $(@el).find("a").click @app.show_local_page
      @

  @app = window.app ? {}
  @app.DepartmentView = DepartmentView
