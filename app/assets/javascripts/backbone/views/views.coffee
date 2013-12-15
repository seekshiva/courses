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
          hod_email: dept.get("hod_email")
        }

      $(@el).html @template
        depts: depts

      $(@el).find("a").click @app.show_local_page

      @

  class SubscriptionsView extends Backbone.View
    el: "#user_menu"
    template: Handlebars.compile($("#usermenu-template").html())

    initialize: ->
      @app = window.app ? {}
      @subscriptions = new @app.SubscriptionsCollection()
      @subscriptions.bind "reset", @render, @
      @subscriptions.bind "add", @render, @
      @subscriptions.bind "remove", @render, @
      @subscriptions.fetch()
      @

    render: () ->
      subs = {}

      subscribed = 0
      attending = 0
      @subscriptions.models.map (sub) ->
        subs[sub.id] = {
          id:             sub.get("id"),
          course_name:    sub.get("course_name"),
          term_id:        sub.get("term_id"),
          attending:      sub.get("attending"),
          current:        sub.get("current")
        }
        if sub.get("attending") != true  && sub.get("current") == true
          subscribed = true
        if sub.get("attending") == true  && sub.get("current") == true
          attending = true

      $(@el).html @template
        user:       @app.user
        subs:       subs
        subscribed: subscribed
        attending:  attending

      $(".local").find("a:not(.external)").click (e) ->
        unless e.target.parentNode.id == "signin_link"
          $("#signin_link").css({display: "block"})
        @app = window.app ? {}
        @app.show_local_page(e)

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

    initialize: (term_view) ->
      @el = "#term_subscription_status"
      @term_id = term_view.term.attributes.subscription.term_id
      @app = term_view.app
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
        @app.menu_view.subscriptions.remove({id: @sub_status.id})
        @sub_status.destroy()
        delete @sub_status.id
        delete @sub_status.attributes.id
        delete @sub_status.attributes.attending
        delete @sub_status.attributes.created_at
        delete @sub_status.attributes.updated_at
      else 
        @sub_status.set({attending : null})
        @sub_status.save(null, { success: _.bind(@updateCollection, @) })
      @

    updateCollection: (model, resp) ->
      @app.menu_view.subscriptions.remove({id: @sub_status.id}).add(@sub_status.attributes)

    updateAttending: (e) ->
      e.preventDefault
      if e.target.id == @term_id+"attending"
        @sub_status.set({attending : true})
      else
        @sub_status.set({attending : false})
      @sub_status.save({}, { success: _.bind(@updateCollection, @) })
      @

    render: ->
      $(".tooltip").remove()
      $("#"+@term_id+"subscription_status").popover("destroy")
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
        status = "Not Subscribed"

      $(@el).html @template
        text: text
        status: status
        sub: sub
        term_id: @term_id

      $('#'+@term_id+'subscription_status').tooltip({title: status}) 
      if @sub_status.attributes.attending == null && @sub_status.id
        $("#"+@term_id+"subscription_status").popover({
          html: true,
          placement: "left",
          trigger: "click",
          content: "Help us to tailor content for you.<br/> Are you attending this course? <br/><br/>
                    <button class='btn btn-default btn-success' id='"+@term_id+"attending'>Yes</button>
                    <button class='btn btn-default' id='"+@term_id+"not_attending'>No</button>",
          container: "body"
        }).popover("show")
        
      $("#"+@term_id+"subscription_status").bind("click", _.bind(@updateSubscription, @))
      $(document).on("click", "#"+@term_id+"attending", _.bind(@updateAttending, @))
      $(document).on("click", "#"+@term_id+"not_attending", _.bind(@updateAttending, @))
      $(document).on("click", (e) -> 
        $("button[id*=subscription_status]").popover("destroy")
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
      "click .delete_section" : "deleteSection"
      "click .delete_topic" : "deleteTopic"
      "click #create_section" : "createSection"
      "click .create_topic" : "createTopic"
      "click .toggle_edit_section" : "toggleSectionEdit"
      "click .toggle_edit_topic" : "toggleTopicEdit"
      "click .edit_section" : "updateSection"
      "click .edit_topic" : "updateTopic"

    initialize: (term_view)=>
      @el = "#specialized_view"
      @term_view = term_view
      @updateSelector()

    createSection: (e) ->
      e.preventDefault()
      title = $.trim($("#new_section_title").val())
      $("#new_section_title").val("")
      if title != ""
        section = new @term_view.app.SectionModel({title : title, term_id: @term_view.term.id})
        that = @
        section.save(null, {success: (model, resp) ->
          that.term_view.term.attributes.sections.push(section.attributes)
          that.render()
        })
      @

    createTopic: (e) ->
      e.preventDefault()
      section_id = $(e.target).attr("section-id")
      topic_title = $.trim($("#topic_title_"+section_id.toString()).val())
      topic_ct = $.trim($("#topic_ct_"+section_id.toString()).val())
      topic_description = $.trim($("#topic_description_"+section_id.toString()).val())
      if topic_title != ""
        topic = new @term_view.app.TopicModel({
            title:          topic_title,
            ct_status:      topic_ct,
            description:    topic_description,
            section_id:     section_id
          })
        that = this
        topic.save(null, {success: (model, resp) -> 
          elem = _.find(that.term_view.term.attributes.sections, (obj) ->  return obj.id.toString() == section_id.toString())
          elem.topics.push(topic.attributes)
          that.render()
          })
      @
    
    toggleSectionEdit: (e) ->
      e.preventDefault()
      section_id = $(e.target).attr("section-id") || $(e.target).parent().attr("section-id")
      if @section_id == section_id
        @section_id = null
      else
        @section_id = section_id
      @topic_id = null
      @render()
      @

    updateSection: (e) ->
      e.preventDefault()
      section_id = $(e.target).attr("section-id") || $(e.target).parent().attr("section-id")
      title = $.trim($("#section_title_"+section_id).val())
      if title != ""
        section = new @term_view.app.SectionModel({id: section_id, title: title})
        that = this
        section.save(null, { success: (model, resp) ->
            elem = _.find(that.term_view.term.attributes.sections, (obj) ->  return obj.id.toString() == section_id.toString())
            elem.title = title
            that.section_id = null
            that.render()
          })
      @

    toggleTopicEdit: (e) ->
      e.preventDefault()
      topic_id = $(e.target).attr("topic-id") || $(e.target).parent().attr("topic-id")
      if @topic_id == topic_id
        @topic_id = null
      else
        @topic_id = topic_id
      @section_id = null
      @render()
      @
      
    updateTopic: (e) ->
      e.preventDefault()
      topic_id = $(e.target).attr("topic-id") || $(e.target).parent().attr("topic-id")
      title = $.trim($("#topic_title_"+topic_id).val())
      ct_status = $.trim($("#topic_ct_"+topic_id).val())
      description = $.trim($("#topic_description_"+topic_id).val())
      if title != ""
        topic = new @term_view.app.TopicModel({id: topic_id, title: title, ct_status: ct_status, description: description})
        that = this
        topic.save(null, { success: (model, resp) ->
            for section in that.term_view.term.attributes.sections
              elem = _.find(section.topics, (topic) -> return topic.id.toString() == topic_id.toString())
              if elem
                elem.title = title
                elem.ct_status = ct_status
                elem.description = description
                break
            that.topic_id = null
            that.render()
          })
      @
      
    deleteSection: (e) -> 
      e.preventDefault()
      section_id = $(e.target).attr("section-id") || $(e.target).parent().attr("section-id")
      section = new @term_view.app.SectionModel({id : section_id})
      section.destroy()
      elem = _.find(@term_view.term.attributes.sections, (obj) ->  return obj.id.toString() == section_id.toString())
      index = @term_view.term.attributes.sections.indexOf(elem)
      @term_view.term.attributes.sections.splice(index, 1)
      @render()
      @

    deleteTopic: (e) ->
      e.preventDefault()
      topic_id = $(e.target).attr("topic-id") || $(e.target).parent().attr("topic-id")
      topic = new @term_view.app.TopicModel({id: topic_id})
      topic.destroy()
      for section in @term_view.term.attributes.sections
        elem = _.find(section.topics, (topic) -> return topic.id.toString() == topic_id.toString())
        if elem
          topic_index = section.topics.indexOf(elem)
          section_index = @term_view.term.attributes.sections.indexOf(section)
          @term_view.term.attributes.sections[section_index].topics.splice(topic_index, 1)
          break
      @render()
      @

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
        if @section_id
          if @section_id.toString() == section.id.toString()
            section_clone["edit"] = true
          else
            section_clone["edit"] = false
        section_clone["topics"] = []
        for topic in section.topics
          topic["edit"] = false
          if @topic_id
            if @topic_id.toString() == topic.id.toString()
              topic["edit"] = true
              delete topic["ct_select"]
              status = topic.ct_status.toString().replace(" ","")
              topic["ct_select"] = {}
              topic["ct_select"][status] = true
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
      avatar = @profile.attributes.avatar_id != 0 ? 1 : 0
      edit = @profile.attributes.type == "edit" ? 1 : 0

      prefix = {}
      if !@profile.attributes.student
        prefix = {"":false,"Dr.":false,"Prof.":false,"Ms.":false,"Mr.":false,"Mrs.":false}
        prefix[@profile.attributes.prefix] = true

      $(@el).html @template
        type:         @profile.attributes.type
        info:         @profile.attributes
        avatar:       avatar
        edit_mode:    edit
        prefix:       prefix

      $(".make-switch").bootstrapSwitch();

      # Uploadify needs csrf tokens & session details
      uploadify_script_data = {};

      csrf_token = $('meta[name=csrf-token]').attr('content');
      csrf_param = $('meta[name=csrf-param]').attr('content');
      uploadify_script_data[csrf_param] = encodeURI(csrf_token);
      uploadify_script_data[app["session_key"]] = app["session_val"];
      
      $("#upload_avatar").uploadify({
          "swf" : "/uploadify.swf",
          "uploader" : "/upload/avatar.json",
          "formData" : uploadify_script_data,
          "buttonText" : "Change Avatar",
          "method" : "post",
          "removeCompleted": true,
          "multi" : false,
          "auto" : true,
          "fileTypeDesc" : "Image",
          "fileSizeLimit" : "1000kb",
          onUploadSuccess : _.bind(@changeprofilepic, @)
        });
      @

    changeprofilepic: (fileobj, resp, status) ->
      resp = JSON.parse(resp)
      @profile.set({avatar_id: resp.id, avatar: resp.url})
      $("#avatar").attr({src: resp.url})
      @

    edit: (e) ->
      e.preventDefault()
      @profile.set({type: "edit"})
      @

    save: (e) ->
      e.preventDefault()
      @profile.set(name : $("#name").val())
      @profile.set(phone : $("#phone").val())
      @profile.set(prefix: $("#prefix").val())
      @profile.set(about: $("#about").val())
      @profile.set(designation: $("#designation").val())
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
  
  @app.DepartmentsView      = DepartmentsView
  @app.SubscriptionsView    = SubscriptionsView
  @app.DepartmentView       = DepartmentView
  @app.CourseView           = CourseView
  @app.TermView             = TermView
  @app.ProfileView          = ProfileView
  @app.LoginView            = LoginView
  @app.NotFoundView         = NotFoundView

