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
    
    initialize: (options) ->
      @app = window.app ? {}
      @view = options.view
      @term = new @app.TermModel({id: options.id})
      @term.bind "change", @render, @
      @term.fetch()
      @

    render: =>
      find_template = (type)->
        Handlebars.compile $("#term-" + type + "-template").html()

      $(@el).html @template
        term: @term.attributes
        edit_mode: if @view.id == "edit" then "edit_mode" else ""

      $(@el).find("#specialized_view_selector li").removeClass("active")
      $(@el).find("#view_term_" + @view.type).addClass("active")

      if @view.type == "topics"
        if @term_topics_view
          @term_topics_view.render()
        else
          @term_topics_view = new TermTopicsView(@)
      else
        $("#specialized_view").html find_template(@view.type)
          term:          @term.attributes
          edit_mode:     if @view.id == "edit" then "edit_mode" else ""
          term_sections: @term_sections

      $(@el).find("a:not(.local-nav a)").click @app.show_local_page
      @



  class TermTopicsView extends Backbone.View
    template: Handlebars.compile($("#term-topics-template").html())
    selectors:
      ct_status:
        "ct1": ""
        "ct2": "btn-info"
        "postct": ""
    events:
      "click #ct_status_selector > .btn": "updateSelector"
      "click .row > .list-group > .list-group-item": "switch_active_topic"

    initialize: (term_view)=>
      @el = "#specialized_view"
      @term_view = term_view
      @updateSelector()

    updateSelector: (e)->
      if e and e.target
        e.preventDefault()
        timeframe = $(e.target).html().toLowerCase().replace(" ", "")
        @selectors.ct_status[timeframe] =  if @selectors.ct_status[timeframe] == "btn-info" then "" else "btn-info"
        flag =  false
        for k,v of @selectors.ct_status
          flag ||= (v == "btn-info")
        
        @selectors.ct_status[timeframe] = "btn-info" if not flag

      @render()
      @


    render: =>
      current_topic = 0

      @term_sections = []
      flag = true
      for section in @term_view.term.attributes.sections
        section_clone = Object.create(section)
        section_clone["topics"] = []
        for topic in section.topics
          if @selectors.ct_status[topic.ct_status.toLowerCase().replace(" ", "")] == "btn-info"
            section_clone.topics.push topic

        if section_clone.topics.length or @term_view.view.id == "edit"
          @term_sections.push(section_clone)
          if section_clone.id == @current_section_id
            section_clone.active = true
            flag = false
          else
            section_clone.active = false

      $(@el).html @template
        term:          @term_view.term.attributes
        edit_mode:     if @term_view.view.id == "edit" then "edit_mode" else ""
        term_sections: @term_sections
        selectors:     @selectors
        show_all:      flag
      @

    switch_active_topic: (e) =>
        @app = window.app ? {}
        target = if e.target.nodeName == "A" then e.target else e.target.parentNode
        $(target).siblings().filter(".active").removeClass("active")
        $(target).addClass("active")

        if target.hash == "#_all_sections"
          @current_section_id = -1
        else
          @current_section_id = +target.hash.substr(10)


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

