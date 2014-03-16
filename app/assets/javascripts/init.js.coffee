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

    $(document).ajaxSend(()->
        $("#content").css({opacity: 0.5});
        $("#loading").css({top: (($(window).height()-180)/2), left: (($(window).width()-128)/2), position: "absolute" }).show(400);
      )

    $(document).ajaxComplete(()->
        $("#content").css({opacity: 1});
        $("#loading").hide(200);
      )

    @app = window.app ? {}
    if app['user']
      @app.menu_view = new @app.SubscriptionsView()
      @app.notification = new @app.NotificationView()
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

    $(".local").find("a:not(.external)").click (e) ->
      unless e.target.parentNode.id == "signin_link"
        $("#signin_link").css({display: "block"})
      @app = window.app ? {}
      @app.show_local_page(e)

    Handlebars.registerHelper('toMarkdown',(value) ->
      return markdown.toHTML(value) if value;
      return "";
    );

    Handlebars.registerHelper('hostName',() ->
      return window.location.host;
    );

    Backbone.history.start({pushState: true})

    $(".selectpicker").selectpicker()
    
    @app.xmpp_client = new @app.Xmpp(app["xmpp_user"], app["xmpp_pass"], window.location.host)