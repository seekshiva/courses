$.ajaxSetup cache: false

@app = window.app ? {}

jQuery ->
  $(document).ready ->
    $.ajaxSetup
      global: true,
      beforeSend: (xhr) ->
        xhr.setRequestHeader("X-CSRF-Token", $("meta[name='csrf-token']").attr("content"))

    Backbone.history.start({pushState: true})

    class SubscriptionModel extends Backbone.Model
      paramRoot: 'subscription'

      defaults:
        term_id:     null
        user_id:     null
        attending:   null

      urlRoot: "/subscriptions/"

    class SubscriptionsCollection extends Backbone.Collection
      model: SubscriptionModel
      url: "/subscriptions/"

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

        attending = 0
        @subscriptions.models.map (sub) ->
          subs[sub.id] = {
            id:             sub.get("id"),
            course_name:    sub.get("course_name"),
            term_id:        sub.get("term_id"),
            attending:      sub.get("attending"),
            current:        sub.get("current")
          }
          if sub.get("current") == true
            attending = true

        $(@el).html @template
          user:       @app.user
          subs:       subs
          attending:  attending
        @

    @app                         = window.app ? {}
    @app.SubscriptionModel       = SubscriptionModel
    @app.SubscriptionsCollection = SubscriptionsCollection
    @app.SubscriptionsView       = SubscriptionsView

    @app.menu_view = new @app.SubscriptionsView()
