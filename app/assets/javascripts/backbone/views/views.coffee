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

      $(@el).find("a").click @app.show_local_page

      @

  class LoginView extends Backbone.View
    template: Handlebars.compile($("#login-template").html())

    el: "#content"

    initialize: ->
      @render()

    render:  ->
      $(@el).html @template
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
      $(@el).find("a").click @app.show_local_page

      @

  class CourseView extends Backbone.View
    template: Handlebars.compile($("#course-template").html())

    el: "#content"
    
    initialize: (options) ->
      @app = window.app ? {}
      @model = @app.CourseModel
      @view = options.view

      if not @app.course 
        @app.course = {id: -1}

      if @app.course.id.toString() != options.id
        @app.course = 
          id: options.id
          topics: []
          classes: []
          render: @render

        $.getJSON("/courses/"+options.id, @setCourse)
        $.getJSON("/courses/"+@app.course.id+"/topics", @setTopics)
        $.getJSON("/courses/"+@app.course.id+"/classrooms", @setClasses)

      else
        @render @app.course

      @

    setCourse:(course) ->
      @app = window.app ? {}
      @topics = @app.course.topics
      @classes = @app.course.classes
      @render = @app.course.render

      @app.course = course
      @app.course.topics = @topics
      @app.course.classes = @classes
      @app.course.render = @render

      @render()
      @

    setTopics:(topics) ->
      @app = window.app ? {}
      @app.course.topics = topics
      @app.course.render()
      @

    setClasses:(classes) ->
      @app = window.app ? {}
      @app.course.classes = classes
      @app.course.render()
      @

    render: =>
      find_template = 
        info        : Handlebars.compile $("#course-info-template").html()
        topics      : Handlebars.compile $("#course-topics-template").html()
        classes     : Handlebars.compile $("#course-classes-template").html()
        reference   : Handlebars.compile $("#course-reference-template").html()

      $(@el).html @template
        course: @app.course

      $("#specialized_view").html find_template[@view.type]
        course: @app.course

      $(@el).find("#specialized_view_selector li").removeClass("active")
      $(@el).find("#view_course_" + @view.type).addClass("active")

      $(@el).find("a:not(.local-nav a)").click @app.show_local_page
      @
      
  class NotFoundView extends Backbone.View
    template: Handlebars.compile($("#404-template").html())

    el: "#content"

    initialize: (path)->
      @path = path
      @render()

    render:  ->
      $(@el).html @template
        url: @path
      @


  @app = window.app ? {}
  @app.DepartmentsView = DepartmentsView
  @app.DepartmentView  = DepartmentView
  @app.CourseView      = CourseView
  @app.LoginView       = LoginView
  @app.NotFoundView    = NotFoundView

