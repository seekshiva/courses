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
    topics_template: Handlebars.compile($("#course-topic-template").html())
    classes_template: Handlebars.compile($("#course-class-template").html())

    el: "#content"

    events:
      "click #view_by_topic": "viewByTopic"
      "click #view_by_class": "viewByClass"
    
    initialize: (options) ->
      @app = window.app ? {}
      @model = @app.CourseModel
      @app.course = 
        id: options.id
        topics: []
        classes: []
        render: @render

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

    setClasses:(classes) ->
      @app = window.app ? {}
      @app.course.classes = classes

    render: (course) =>
      $(@el).html @template
        course: course
        plural: "s" if course.departments.length != 1
      @

    viewByTopic: ->
      $("#specialized_view").html @topics_template
        topics: @app.course.topics
      @

    viewByClass: ->
      $("#specialized_view").html @classes_template
        classes: @app.course.classes
      @

      


  @app = window.app ? {}
  @app.DepartmentsView = DepartmentsView
  @app.DepartmentView  = DepartmentView
  @app.CourseView      = CourseView

