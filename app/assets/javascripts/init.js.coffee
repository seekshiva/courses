$.ajaxSetup cache: false

@app = window.app ? {}

jQuery ->
  $(document).ready ->
    @app = window.app ? {}
    @app.menu_view = new @app.SubscriptionsView()
    @app.router = new @app.ApplicationRouter()

    $.ajaxSetup
      global: true,
      beforeSend: (xhr) ->
        xhr.setRequestHeader("X-CSRF-Token", $("meta[name='csrf-token']").attr("content"))

    @app.show_local_page = (e)->
      e.preventDefault()
      @app = window.app ? {}
      @app.router.navigate $(e.target).attr("href") or $(e.target.parentNode).attr("href"),
        trigger: true

    $(".local").find("a:not(.external)").click (e) ->
      unless e.target.parentNode.id == "signin_link"
        $("#signin_link").css({display: "block"})

      @app = window.app ? {}
      @app.show_local_page(e)

    Backbone.history.start({pushState: true})

    $(".selectpicker").selectpicker()
