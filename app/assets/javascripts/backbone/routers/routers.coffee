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
      "profile/:id" : "profile"
      "profile/:id(/:slug)" : "profile"
      "login": "login"
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
      if @term_view and @term_view.id == term_id
        @term_view.view =
          type: type or "info"
          id: id
        @term_view.render()
      else
        @term_view = new @app.TermView
          id: term_id
          view:
            type: type or "info"
            id: id
      @

    profile: (id, type) ->
      @profile_view = new @app.ProfileView
        id: id
        type: type or "show"
      @

    login: () ->
      $("#signin_link").css
        display: "none"
      if @app.user
        @home()
      else
        @login_view = new @app.LoginView()
      @

    four_oh_four: (path) ->
      @not_found_view = new @app.NotFoundView
        path: path

    initialize: (options) ->
      @app = window.app ? {}

  @app = window.app ? {}
  @app.ApplicationRouter = ApplicationRouter
  @
