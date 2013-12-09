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

      if @term_sub_status
        @term_sub_status.render()
      else 
        @term_sub_status = new TermSubscriptionView(@)

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

  class TermSubscriptionView extends Backbone.View
    template: Handlebars.compile $("#term-subscription-template").html()

    events:
      "click #subscription_status" : "updateSubscription"

    initialize: (term_view) ->
      @el = "#term_subscription_status"
      @sub_status = new term_view.app.SubscriptionModel()
      @sub_status.bind "destroy", @render, @
      if term_view.term.attributes.subscription.id
        @sub_status.set({id : term_view.term.attributes.subscription.id})
        @sub_status.bind "change", @render, @
        @sub_status.fetch()
      else
        @sub_status.bind "change", @render, @
        @sub_status.set({ user_id : term_view.term.attributes.subscription.user_id, term_id : term_view.term.attributes.subscription.term_id })
      @

    updateSubscription: (e) ->
      e.preventDefault()
      if @sub_status.id
        @sub_status.destroy()
        delete @sub_status.id
        delete @sub_status.attributes.id
        delete @sub_status.attributes.attending
        delete @sub_status.attributes.created_at
        delete @sub_status.attributes.updated_at
      else 
        @sub_status.save()
      @

    updateAttending: (e) ->
      e.preventDefault
      if e.target.id == "attending"
        @sub_status.set({attending : true})
      else
        @sub_status.set({attending : false})
      @sub_status.save()
      @

    render: ->
      $(".tooltip").remove()
      $("#subscription_status").popover("destroy")
      sub = 0
      if @sub_status.attributes.id
        sub = 0
        text = "Unsubscribe"
        if @sub_status.attributes.attending == true
          status = "Subscribed and attending"
        else 
          status = "You have subscribed to the course but not attending it"
      else
        sub = 1 
        text = "Subscribe"
        status = "Unsubscribed"

      $(@el).html @template
        text: text
        status: status
        sub: sub

      $('#subscription_status').tooltip({title: status}) 
      if @sub_status.attributes.attending == null && @sub_status.id
        $("#subscription_status").popover({
          html: true,
          placement: "left",
          trigger: "click",
          content: "Help us to tailor content for you.<br/> Are you attending this course? <br/><br/>
                    <button class='btn btn-default btn-success' id='attending'>Yes</button>
                    <button class='btn btn-default' id='not_attending'>No</button>",
          container: "body"
        }).popover("show")
        
      $(document).on("click", "#attending", _.bind(@updateAttending, @))
      $(document).on("click", "#not_attending", _.bind(@updateAttending, @))
      $(document).on("click", (e) -> 
        $("#subscription_status").popover("destroy")
      )
      @

  class TermTopicsView extends Backbone.View
    template: Handlebars.compile($("#term-topics-template").html())
    selectors:
      ct_status:
        "ct1": "btn-info"
        "ct2": "btn-info"
        "postct": "btn-info"
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

  class ProfileView extends Backbone.View
    template: Handlebars.compile($("#profile-template").html())

    el: "#content"

    events:
      "click #edit" : "edit"
      "click #save" : "save"

    initialize: (options) ->
      @app = window.app ? {}
      @options = options
      @profile = new @app.ProfileModel({id: options.id, type: options.type})
      @profile.bind "change", @render, @
      @profile.fetch()
      @

    render: ->
      avatar = @profile.avatar == "" ? 0 : 1
      edit = @profile.attributes.type == "edit" ? 1 : 0
      $(@el).html @template
        type:         @profile.attributes.type
        info:         @profile.attributes
        avatar:       avatar
        edit_mode:    edit

      $(".make-switch").bootstrapSwitch();
      @

    edit: (e) ->
      e.preventDefault()
      @profile.set({type: "edit"})
      @

    save: (e) ->
      e.preventDefault()
      @profile.set(name : $("#name").val())
      @profile.set(phone : $("#phone").val())
      @profile.save()
      @profile.set({type: "show"})
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
  @app.ProfileView     = ProfileView
  @app.LoginView       = LoginView
  @app.NotFoundView    = NotFoundView

