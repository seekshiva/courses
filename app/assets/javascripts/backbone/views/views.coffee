jQuery ->
  class DepartmentsView extends Backbone.View
    el: "#content"
    template: Handlebars.compile($("#departments-template").html())

    initialize: ->
      @app = window.app ? {} 
      @departments = new @app.DepartmentsCollection()  
      @departments.bind "reset", @render, @
      @departments.fetch()
      @

    render: ->
      depts = {}

      @departments.models.map (dept) ->
        depts[dept.id] = {
          id: dept.get("id")
          name: dept.get("name")
          hod: dept.get("hod")
        }

      $(@el).html @template
        depts: depts

      $(@el).find("a").click @app.show_local_page

      @

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
      $(@el).html @template
        dept: @department.attributes
      $(@el).find("a").click @app.show_local_page
      @

  class CourseView extends Backbone.View
    template: Handlebars.compile($("#course-template").html())

    el: "#content"
    
    initialize: (options) ->
      @app = window.app ? {}
      @view = options.view
      @course = new @app.CourseModel({id: options.id})
      @course.bind "change", @render, @
      @course.bind "destroy", @render, @
      @course.fetch()

      @

    render: =>
      find_template = (type)->
        Handlebars.compile $("#course-" + type + "-template").html()

      $(@el).html @template
        course: @course.attributes

      $("#specialized_view").html find_template(@view.type)
        course: @course.attributes

      $(@el).find("#specialized_view_selector li").removeClass("active")
      $(@el).find("#view_course_" + @view.type).addClass("active")

      $(@el).find("a:not(.local-nav a)").click @app.show_local_page
      @

  class TermView extends Backbone.View
    template: Handlebars.compile($("#term-template").html())

    el: "#content"
    events:
      "click #ct_status_selector > .btn": "updateSelector"
    
    initialize: (options) ->
      @app = window.app ? {}
      @view = options.view
      @selectors =
        ct_status:
          "ct1": "active"
          "ct2": "active"
          "postct": "active"
      @term = new @app.TermModel({id: options.id})
      @term.bind "change", @render, @
      @term.fetch()

      @

    updateSelector: (e)->
      if e
        timeframe = $(e.target).html().toLowerCase().replace(" ", "")
        @selectors.ct_status[timeframe] =  if @selectors.ct_status[timeframe] == "active" then "" else "active"
        flag =  false
        for k,v of @selectors.ct_status
          flag ||= (v == "active")
        
        @selectors.ct_status[timeframe] = "active" if not flag

      @term_topics = []
      for topic in @term.attributes.topics
        topic_clone = Object.create(topic)
        topic_clone["sections"] = []
        for section in topic.sections
          if @selectors.ct_status[section.ct_status.toLowerCase().replace(" ", "")] == "active"
            topic_clone.sections.push section
        @term_topics.push(topic_clone) if topic_clone.sections.length
      @render()
      @

    render: =>
      @updateSelector() if not @term_topics
      find_template = (type)->
        Handlebars.compile $("#term-" + type + "-template").html()

      $(@el).html @template
        term: @term.attributes
        selectors:   @selectors

      $("#specialized_view").html find_template(@view.type)
        term:        @term.attributes
        term_topics: @term_topics

      if @view.type == "topics"
        $(@el).find("#ct_status_selector").show()
      else
        $(@el).find("#ct_status_selector").hide()

      $(@el).find("#specialized_view_selector li").removeClass("active")
      $(@el).find("#view_term_" + @view.type).addClass("active")

      $(@el).find("a:not(.local-nav a)").click @app.show_local_page
      @

  class LoginView extends Backbone.View
    template: Handlebars.compile($("#login-template").html())

    el: "#content"

    initialize: ->
      @render()

    render:  ->
      $(@el).html @template
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
  @app.TermView        = TermView
  @app.LoginView       = LoginView
  @app.NotFoundView    = NotFoundView

