jQuery ->
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

      document.title = "CoursesHub - "+@profile.attributes.name

      prefix = {}
      if !@profile.attributes.student
        prefix = {" ":false,"Dr.":false,"Prof.":false,"Ms.":false,"Mr.":false,"Mrs.":false}
        if @profile.attributes.prefix != null
          prefix[@profile.attributes.prefix] = true
        else 
          prefix[" "] = true

      $(@el).html @template
        type:         @profile.attributes.type
        info:         @profile.attributes
        avatar:       avatar
        edit_mode:    edit
        prefix:       prefix

      $(".make-switch").bootstrapSwitch();
      $(".selectpicker").selectpicker()

      # Uploadify needs csrf tokens & session details
      uploadify_script_data = {};

      csrf_token = $('meta[name=csrf-token]').attr('content');
      csrf_param = $('meta[name=csrf-param]').attr('content');
      uploadify_script_data[csrf_param] = encodeURI(csrf_token);
      uploadify_script_data[app["session_key"]] = app["session_val"];
      
      $("#upload_avatar").uploadify({
          "swf" : "/swf/uploadify.swf",
          "uploader" : "/upload/avatar.json",
          "formData" : uploadify_script_data,
          "buttonText" : "Change Avatar",
          "method" : "post",
          "removeCompleted": true,
          "multi" : false,
          "auto" : true,
          "fileTypeDesc" : "Image",
          "fileSizeLimit" : "6000KB",
          onUploadSuccess : _.bind(@changeprofilepic, @)
        });
      @

    changeprofilepic: (fileobj, resp, status) ->
      resp = JSON.parse(resp)
      if(resp.status.toString() == "0")
        @profile.set({avatar_id: resp.id, avatar: resp.url})
        $("#avatar").attr({src: resp.url})
      else 
        $("#" + fileobj.id).css("background-color", "#FDE5DD").find('.data').css('color', 'red').html(' - ' + resp.msg + " - " + resp.error.pic[0]);
      @

    edit: (e) ->
      e.preventDefault()
      @profile.set({type: "edit"})
      @

    save: (e) ->
      e.preventDefault()
      data = {  
                name : $("#name").val(),
                phone : $("#phone").val(),
                prefix: $("#prefix").val(),
                about: $("#about").val(),
                designation: $("#designation").val()
              }
      @profile.set(data)
      @profile.save()
      @profile.set({type: "show"})
      @

  @app = window.app ? {}
  @app.ProfileView = ProfileView

