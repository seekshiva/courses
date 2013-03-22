jQuery ->
  class ApplicationRouter extends Backbone.Router
    app: window.app ? {}
    routes:
      "": "home"
      "departments": "index"
      "departments/:id": "department"
      "courses/:course_id(/:slug)": "course"
      "courses/:course_id/:slug(/:id)": "course"
      "login": "login"
      "signout": "signout"
      "me": "me"
      "*path": "four_oh_four"

    home: () ->
      @app.router.navigate("/departments", {trigger: true})
      @

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

    me: () ->
      $("#profileModal").modal()
      @

    login: () ->
      $("#signin_link").css({display: "none"})
      if @app.user
        @home()
      else
        @login_view = new @app.LoginView()
      @

    signout: () ->
      window.location.href = window.location.href
      @

    four_oh_four: (path) ->
      @not_found_view = new @app.NotFoundView(path: path)
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
      @view = new Courses.Views.Departments.IndexView(departments: @departments)
      $("#departments").html(@view.render().el)

    show: (id) ->
      department = @departments.get(id)

      @view = new Courses.Views.Departments.ShowView(model: department)
      $("#departments").html(@view.render().el)

  @app = window.app ? {}
  @app.ApplicationRouter = ApplicationRouter
  @
