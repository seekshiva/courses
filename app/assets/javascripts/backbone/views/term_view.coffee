jQuery ->
  class TermView extends Backbone.View
    template: Handlebars.compile($("#term-template").html())

    el: "#content"

    events:
      "click .row > .list-group > .list-group-item": "switch_active_topic"
      "click #create_section" : "createSection"
      "submit .create_subtopic" : "createSubTopic"
      "click .ct_select_btn.input-group-btn li" : "updateCTSelection"
      "click .delete_section" : "deleteSection"
      "click .edit_section" : "updateSection"
    
    initialize: (options) ->
      @app = window.app ? {}
      @view = options.view
      @term_id = options.id
      @term = new @app.TermModel({id: @term_id})
      @term.bind "change", @render, @
      @term.fetch()
      @tab = {}
      @tab["info"] = {"overview":true, "instructor": false, "outline": false}
      @tab["reference"] = {"books": true, "notes": false}
      @

    switch_active_topic: (e) =>
      @app = window.app ? {}
      target = $(e.target).closest("a")
      $(target).siblings().filter(".active").removeClass("active")
      $(target).addClass("active")

    updateSection: (e) ->
      e.preventDefault()
      section_id = $(e.target).attr("section-id") || $(e.target).parent().attr("section-id")
      title = $.trim($("#section_title_"+section_id).val())
      if title != ""
        section = new @term_view.app.SectionModel({id: section_id, title: title})
        that = this
        section.save null, success: (model, resp) ->
          term_attributes = that.term_view.term.attributes
          elem = _.find term_attributes.sections, (obj) ->
            return obj.id.toString() == section_id.toString()
          elem.title = title
          that.section_id = null
          that.render()

      @

    updateCTSelection: (e)->
      e.preventDefault()
      val = $(e.target).text()
      btn = $(e.target).closest(".ct_select_btn")
      $(btn).find("button > span").text(val)
      $(btn).siblings("[type=hidden]").val(val)
      @

    deleteSection: (e) ->
      e.preventDefault()
      unless confirm("Are you sure you want to delete this?")
        return
      section_id = $(e.target).attr("section-id") || $(e.target).parent().attr("section-id")
      section = new @app.SectionModel({id : section_id})
      section.destroy()
      elem = _.find @term.attributes.sections, (obj) ->
        return obj.id.toString() == section_id.toString()
      index = @term.attributes.sections.indexOf(elem)
      @tab["info"] = {"overview":false, "instructor": false, "outline": true}
      @term.attributes.sections.splice(index, 1)
      @render()
      @

    createSection: (e) ->
      e.preventDefault()
      title = $.trim($("#new_section_title").val())
      $("#new_section_title").val("")
      @tab["info"] = {"overview":false, "instructor": false, "outline": true}
      if title != ""
        section = new @app.SectionModel
          title   : title
          term_id : @term_id
        that = this
        section.save(null, {success: (model, resp) ->
          that.term.attributes.sections.push(section.attributes)
          that.render()
        })
      @

    createSubTopic: (e) ->
      e.preventDefault()
      target = e.target
      section_id = parseInt($(e.target).attr("section-id"))
      topic_title = $.trim($(target).find("#topic_title").val())
      topic_ct = $.trim($("#topic_ct_status").val())
      if topic_title != ""
        topic = new @app.TopicModel({
          title:          topic_title,
          ct_status:      topic_ct,
          description:    "",
          section_id:     section_id
        })
        that = this
        @tab["info"] = {"overview":false, "instructor": false, "outline": true}
        topic.save null, success: (model, resp) ->
          term = that.term
          elem = _.find term.attributes.sections, (obj) ->
            return obj.id == section_id
          elem.topics.push(topic.attributes)
          that.render()
      @

    render: =>
      find_template = (type)->
        Handlebars.compile $("#term-" + type + "-template").html()

      $(@el).html @template
        term: @term.attributes

      $("#TermSubModal").modal({"backdrop":"static","show":false});
      $(@el).find("#specialized_view_selector li").removeClass("active")
      $(@el).find("#view_term_" + @view.type).addClass("active")

      document.title = @term.attributes.course.name

      if @view.type == "topics"
        (new @app.TermTopicsView).render(@)
      else
        $("#specialized_view").html find_template(@view.type)
          term:          @term.attributes
          term_sections: @term_sections
          host:          window.location.host
          tab:           @tab[@view.type]
        @app.hide_loading()

      that = this
      $(@el).find("a.local, .local a:not(.external)").click( (e) ->
        $('#TermSubModal').modal("hide").remove();
        $('.modal-backdrop').remove();
        $('body').removeClass( "modal-open" );
        that.app.show_local_page(e)
      )

      if @view.type == "reference"
        # Uploadify needs csrf tokens & session details
        @tab["reference"] = {"books": true, "notes": false}

        uploadify_script_data = {};

        csrf_token = $('meta[name=csrf-token]').attr('content');
        csrf_param = $('meta[name=csrf-param]').attr('content');
        uploadify_script_data[csrf_param] = encodeURI(csrf_token);
        uploadify_script_data[app["session_key"]] = app["session_val"];
        
        $("#upload_notes").uploadify({
          "swf" : "/swf/uploadify.swf",
          "uploader" : "/upload/document.json",
          "formData" : uploadify_script_data,
          "buttonText" : "Upload Notes",
          "method" : "post",
          "removeCompleted": true,
          "multi" : false,
          "auto" : true,
          "fileSizeLimit" : "30000KB",
          onUploadSuccess : _.bind(@addnotes, @)
        });
        
      else if @view.type == "info"
        @tab["info"] = {"overview":true, "instructor": false, "outline": false}
        @term_sub_status = new @app.TermSubscriptionView
        @term_sub_status.initialize(@)
        @term_sub_status.render()
      @

    addnotes: (fileobj, resp, status) ->
      resp = JSON.parse(resp)
      term_doc = new @app.TermDocumentModel({term_id: @term_id, document_id: resp.id})
      that = this
      @tab["reference"] = {"books": false, "notes": true}
      term_doc.save(null, {success: () ->
          that.term.attributes.attachments.push({id: term_doc.id, name: resp.name, url: resp.url})
          that.render()
        })
      @

  @app = window.app ? {}
  @app.TermView = TermView

