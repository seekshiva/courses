jQuery ->
  class ApplicationRouter extends Backbone.Router
    app: window.app ? {}
    routes:
      "": "index"
      "departments": "index"
      "departments/:id": "department"
      "courses/:course_id(/:slug)": "course"
      "courses/:course_id/:slug(/:id)": "course"

    index: () ->
      @departments_view = new @app.DepartmentsView()
      @

    department: (id) ->
      @department_view = new @app.DepartmentView(id: id)
      @

    course: (course_id, type, id) ->
      console.log "in course router method"
      @course_view = new @app.CourseView(id: course_id, view: {type: type, id: id})
      @

    initialize: (options) ->
      @app = window.app ? {}

  class Courses.Routers.DepartmentsRouter extends Backbone.Router

    initialize: (options) ->
      @departments = new Courses.Collections.DepartmentsCollection()
      @departments.reset options.departments

    routes:
      "index"    : "index"
      ":id"      : "show"
      ".*"       : "index"

    index: ->
      console.log "dagaq"
      @view = new Courses.Views.Departments.IndexView(departments: @departments)
      $("#departments").html(@view.render().el)

    show: (id) ->
      department = @departments.get(id)

      @view = new Courses.Views.Departments.ShowView(model: department)
      $("#departments").html(@view.render().el)

  @app = window.app ? {}
  @app.ApplicationRouter = ApplicationRouter
  @
