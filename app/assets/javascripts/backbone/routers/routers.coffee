jQuery ->
  class ApplicationRouter extends Backbone.Router
    routes:
      "": "home"
      "departments": "index"
      "departments/:id": "department"
      "courses/:course_id(/:slug)": "course"
      "courses/:course_id/:slug(/:id)": "course"
      "terms/:term_id(/:slug)": "term"
      "terms/:term_id/:slug(/:id)": "term"
      "login": "login"
      "signout": "signout"
      "me": "me"
      "*path": "four_oh_four"

    home: () ->
      @departments_view = new @app.DepartmentsView()
      @

    index: () ->
      @departments_view = new @app.DepartmentsView()
      @

    department: (id) ->
      @department_view = new @app.DepartmentView
        id: id
      @

    course: (course_id, type, id) ->
      @course_view = new @app.CourseView
        id: course_id
        view:
          type: type or "info"
          id: id
      @

    term: (term_id, type, id) ->
      @term_view = new @app.TermView
        id: term_id
        view:
          type: type or "info"
          id: id
      @

    me: () ->
      $("#profileModal").modal()
      @

    login: () ->
      $("#signin_link").css
        display: "none"
      if @app.user
        @home()
      else
        @login_view = new @app.LoginView()
      @

    signout: () ->
      window.location.href = window.location.href
      @

    four_oh_four: (path) ->
      @not_found_view = new @app.NotFoundView
        path: path

    initialize: (options) ->
      @app = window.app ? {}

  @app = window.app ? {}
  @app.ApplicationRouter = ApplicationRouter
  @
