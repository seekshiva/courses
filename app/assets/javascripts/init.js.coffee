$.ajaxSetup cache: false

@app = window.app ? {}

jQuery ->
  $(document).ready ->
    @app = window.app ? {}
    @app.controller = new @app.AppController()
    @app.router = new @app.ApplicationRouter()

    $.ajaxSetup
      global: true,
      beforeSend: (xhr) ->
        xhr.setRequestHeader("X-CSRF-Token", $("meta[name='csrf-token']").attr("content"))



    $(".local").find("a").click (e) ->
      unless e.target.parentNode.id == "signin_link"
        $("#signin_link").css({display: "block"})
      
      @app = window.app ? {}
      e.preventDefault()
      @app.router.navigate($(e.target).attr("href"), {trigger: true})

    Backbone.history.start({pushState: true})

    $("#profileModal").on "hide", () ->
      if window.history.length == 1
        @app = window.app ? {}
        @app.router.navigate("/departments", {trigger: true})
      else if window.location.hash == "#me"
        window.history.back()
