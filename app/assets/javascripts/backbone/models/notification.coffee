jQuery ->
  class NotificationModel extends Backbone.Model
    paramRoot: 'notification'

    defaults:
      msg:          null
      link:         null
      message_id:   null
      time:         null

    urlRoot: "/notifications/"

  class NotificationsCollection extends Backbone.Collection
    model: NotificationModel
    last: null
    url: "/notifications/"

  @app = window.app ? {}
  
  @app.NotificationModel       = NotificationModel
  @app.NotificationsCollection = NotificationsCollection

