jQuery ->
  class ApplicationRouter extends Backbone.Router
    app: window.app ? {}
    routes:
      "": "index"
      "departments": "index"
      "departments/:id": "department"

    index: () ->
      @departments_view = new @app.DepartmentsView()
      @

    department: (id) ->
      console.log "id: " + id
      @department_view = new @app.DepartmentView(id: id)
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
