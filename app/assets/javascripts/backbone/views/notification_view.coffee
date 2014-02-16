jQuery ->
  class NotificationView extends Backbone.View
    template: Handlebars.compile($("#notification-template").html())

    el: "#notifications-container"

    initialize: (options) ->
      # @app = window.app ? {}
      # @options = options
      # @notifications = new @app.NotificationsCollection({})
      # @notifications.bind "change", @render, @
      # @notifications.fetch()
      @render()
      @

    render: () ->
      $(@el).html @template
      # $(@el).find("a").click @app.show_local_page
      options = {
        animation: true,
        html: true,
        placement: "bottom",
        title: "Notifications",
        content: 'Some random text to test the width',
        delay: { show: 100, hide: 100 },
        template: '<div class="popover notification-inner-popover"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>'
      }
      $("#notification-popover").popover("destroy")
      $("#notification-popover").popover(options)
      @

  @app = window.app ? {}
  @app.NotificationView = NotificationView