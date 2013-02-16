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
      @app = window.app ? {}
      e.preventDefault()
      @app.router.navigate($(e.target).attr("href"), {trigger: true})

    Backbone.history.start({pushstate: true})

