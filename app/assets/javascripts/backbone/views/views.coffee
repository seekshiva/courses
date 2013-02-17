jQuery ->
  class DepartmentsView extends Backbone.View
    el: "#content"
    template: Handlebars.compile($("#departments-template").html())

    initialize: ->
      @app = window.app ? {}
      @app.departments = @app.controller.getCollection("departments_collection")
      @app.departments.bind "reset", @render, @
      @

    render: ->
      depts = {}

      @app.departments.models.map (dept) ->
        depts[dept.id] = {
          id: dept.get("id")
          name: dept.get("name")
          hod: dept.get("hod")
        }

      $(@el).html @template
        depts: depts


      @

  class DepartmentView extends Backbone.View
    template: Handlebars.compile($("#department-template").html())

    el: "#content"

    initialize: (options) ->
      @options = options
      @app = window.app ? {}
      @model = @app.DepartmentModel

      $.getJSON("/departments/"+options.id, @render)

    render: (dept) =>
      $(@el).html @template
        dept: dept

      @

  class CourseView extends Backbone.View
    template: Handlebars.compile($("#course-template").html())

    el: "#content"

    initialize: (options) ->
      @app = window.app ? {}
      @model = @app.CourseModel

      $.getJSON("/courses/"+options.id, @render)

    render: (course) =>
      $(@el).html @template
        course: course

      @


  @app = window.app ? {}
  @app.DepartmentsView = DepartmentsView
  @app.DepartmentView  = DepartmentView
  @app.CourseView      = CourseView

