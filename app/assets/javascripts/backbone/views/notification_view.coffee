jQuery ->
  class NotificationView extends Backbone.View
    template: Handlebars.compile($("#notification-template").html())

    el: "#notifications-container"

    initialize: (options) ->
      @app = window.app ? {}
      @options = options
      @notifications = new @app.NotificationsCollection({})
      delete @notifications.models[0]
      @notifications.bind "change", @render, @
      # @notifications.fetch()
      @render()
      @

    render: () ->
      content = 'No new Messages'
      if @notifications.length > 0
        content = ""

      @notifications.models.map (msg) ->
        console.log(msg)
        content += "<div class='notification-message'><a href='"+msg.get("link")+"'>"+msg.get("msg")+"</a></div>"

      $(@el).html @template
      
      options = {
        animation: true,
        html: true,
        placement: "bottom",
        title: "Notifications",
        content: "<div class='nano-content'>"+content+"</div>",
        template: '<div class="popover notification-inner-popover"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content nano"><p></p></div></div></div>'
      }
      $("#notification-popover").popover("destroy")
      $("#notification-popover").popover(options)
      $("#notification-popover").on("shown.bs.popover", ()=>
          $(@el).find("a").click @app.show_local_page
          $(".nano").nanoScroller();
        )
      @

  @app = window.app ? {}
  @app.NotificationView = NotificationView