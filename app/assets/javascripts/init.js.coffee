$.ajaxSetup cache: false

@app = window.app ? {}

jQuery ->
  $(document).ready ->
    $.ajaxSetup
      global: true,
      beforeSend: (xhr) ->
        xhr.setRequestHeader("X-CSRF-Token", $("meta[name='csrf-token']").attr("content"))

    $(document).ajaxError (e, req, settings) ->
      console.log("AjaxError");
      if req.status == 404 && req.responseText != "saved"
        @app.router.four_oh_four(settings.url)
      else if req.status == 401 && req.responseText != "saved"
        @app.router.login(settings.url)
      else if req.status == 500 && req.responseText != "saved"
        view = new @app.ServerErrorView()


    @app = window.app ? {}
    @app.menu_view = new @app.SubscriptionsView()
    @app.router = new @app.ApplicationRouter()
    @app.router.bind('all', (route) ->
      ga('send', 'pageview', {
        'page' : window.location.pathname,
        'title' : document.title
      });
    )

    @app.show_local_page = (e)->
      unless e.ctrlKey or e.shiftKey
        e.preventDefault()
        @app = window.app ? {}
        @app.router.navigate $(e.target).attr("href") or $(e.target.parentNode).attr("href"),
          trigger: true

    @app.show_loading = ()->
      $("#content").css({opacity: 0.5});
      $("#loading").css({top: (($(window).height()-180)/2), left: (($(window).width()-128)/2), position: "absolute" }).show(400);


    @app.hide_loading = ()->
      $("#content").css({opacity: 1});
      $("#loading").hide(200);

    $(document).ajaxSend(@app.show_loading)

    # $(document).ajaxComplete(@app.hide_loading)

    $(".local").find("a:not(.external)").click (e) ->
      unless e.target.parentNode.id == "signin_link"
        $("#signin_link").css({display: "block"})
      @app = window.app ? {}
      @app.show_local_page(e)

    Handlebars.registerHelper('toMarkdown',(value) ->
      return markdown.toHTML(value) if value;
      return "";
    );

    Handlebars.registerHelper('previewUrl',(url, name) ->
      token = app.user.doc_access_token;
      path = url.split("?")
      csrf_token = path[1]
      path = path[0]
      url = window.location.host+path+"/"+name+"?"+csrf_token+"&access_token="+token
      return "http://docs.google.com/viewer?url="+encodeURIComponent(url)
    );

    Backbone.history.start({pushState: true})

    $(".selectpicker").selectpicker()
    