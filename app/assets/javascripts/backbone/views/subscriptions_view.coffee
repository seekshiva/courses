jQuery ->
  class SubscriptionsView extends Backbone.View
    el: "#user_menu"
    template: Handlebars.compile($("#usermenu-template").html())

    initialize: ->
      @app = window.app ? {}
      @subscriptions = new @app.SubscriptionsCollection()
      @subscriptions.bind "sync", @render, @
      @subscriptions.bind "add", @render, @
      @subscriptions.bind "remove", @render, @
      @subscriptions.fetch()
      @

    render: () ->
      subs = {}

      attending = 0
      _.map( @subscriptions.models, (sub) ->
        subs[sub.id] = {
          id:             sub.get("id"),
          course_name:    sub.get("course_name"),
          term_id:        sub.get("term_id"),
          attending:      sub.get("attending"),
          current:        sub.get("current")
        }
        if sub.get("current") == true
          attending = true
      )
      
      $(@el).html @template
        user:       @app.user
        subs:       subs
        attending:  attending

      @app.hide_loading()

      $(".local").find("a:not(.external)").click (e) ->
        unless e.target.parentNode.id == "signin_link"
          $("#signin_link").css({display: "block"})
        @app = window.app ? {}
        @app.show_local_page(e)

      @

  @app = window.app ? {}
  @app.SubscriptionsView = SubscriptionsView

