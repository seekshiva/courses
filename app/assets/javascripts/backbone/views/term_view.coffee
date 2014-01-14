jQuery ->
  class TermView extends Backbone.View
    template: Handlebars.compile($("#term-template").html())

    el: "#content"
    
    initialize: (options) ->
      @app = window.app ? {}
      @view = options.view
      @term_id = options.id
      @term = new @app.TermModel({id: @term_id})
      @term.bind "change", @render, @
      @term.fetch()
      @

    render: =>
      find_template = (type)->
        Handlebars.compile $("#term-" + type + "-template").html()

      $(@el).html @template
        term: @term.attributes
        edit_mode: if @view.id == "edit" then "edit_mode" else ""

      $("#TermSubModal").modal({"backdrop":"static","show":false});
      $(@el).find("#specialized_view_selector li").removeClass("active")
      $(@el).find("#view_term_" + @view.type).addClass("active")

      document.title = @term.attributes.course.name

      if @view.type == "topics"
        if @term_topics_view
          @term_topics_view.render()
        else
          @term_topics_view = new @app.TermTopicsView(@)
      else
        $("#specialized_view").html find_template(@view.type)
          term:          @term.attributes
          edit_mode:     if @view.id == "edit" then "edit_mode" else ""
          term_sections: @term_sections
          host:          window.location.host

      that = this
      $(@el).find("a:not(.local-nav a, .external)").click( (e) ->
          $('#TermSubModal').modal("hide").remove();
          $('.modal-backdrop').remove();
          $('body').removeClass( "modal-open" );
          that.app.show_local_page(e)
      )

      if @view.type == "reference"
        # Uploadify needs csrf tokens & session details
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
        if @term_sub_status
          @term_sub_status.render()
        else 
          @term_sub_status = new @app.TermSubscriptionView(@)
      @

    addnotes: (fileobj, resp, status) ->
      resp = JSON.parse(resp)
      term_doc = new @app.TermDocumentModel({term_id: @term_id, document_id: resp.id})
      that = this
      term_doc.save(null, {success: () ->
          that.term.attributes.attachments.push({id: term_doc.id, name: resp.name, url: resp.url})
          that.render()
        })
      @

  @app = window.app ? {}
  @app.TermView = TermView

