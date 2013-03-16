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

      @

  class CourseView extends Backbone.View
    template: Handlebars.compile($("#course-template").html())

    el: "#content"

    events:
      "click #view_by_topic": "viewTopics"
      "click #view_by_class": "viewClasses"
    
    initialize: (options) ->
      @app = window.app ? {}
      @model = @app.CourseModel
      @view = options.view

      @viewTopics = @setView("topics")
      @viewClasses = @setView("classes")

      unless @app.course 
        @app.course = {id: -1}

      console.log options.id
      console.log @app.course.id
      if @app.course.id.toString() != options.id #or not @app.course.subject_code
        @app.course = 
          id: options.id
          topics: []
          classes: []
          render: @render

        #console.log @app.course.subject_code
        $.getJSON("/courses/"+options.id, @setCourse)
        $.getJSON("/courses/"+@app.course.id+"/topics", @setTopics)
        $.getJSON("/courses/"+@app.course.id+"/classrooms", @setClasses)


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

      @render @app.course
      @

    setTopics:(topics) ->
      @app = window.app ? {}
      @app.course.topics = topics
      @app.course.render @app.course
      @

    setClasses:(classes) ->
      @app = window.app ? {}
      @app.course.classes = classes
      @app.course.render @app.course
      @

    render: (course) =>
      $(@el).html @template
        course: course
        topics_view_state:  " active" if @view.type == "topics"
        classes_view_state: " active" if @view.type == "classes"
        plural: "s" if course.departments && course.departments.length != 1
      @setView(@view.type)()
      @

    setView:(type) ->
      
      ->
        topics_template = Handlebars.compile($("#course-topic-template").html())
        classes_template = Handlebars.compile($("#course-class-template").html())
        if(type=="topics")
          $("#specialized_view").html topics_template
            course: @app.course
        if(type=="classes")
          $("#specialized_view").html classes_template
            course: @app.course
        @



  @app = window.app ? {}
  @app.DepartmentsView = DepartmentsView
  @app.DepartmentView  = DepartmentView
  @app.CourseView      = CourseView
  @app.LoginView       = LoginView

