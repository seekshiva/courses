jQuery ->
  class NotificationModel extends Backbone.Model
    paramRoot: 'notification'

    defaults:
      message_id:   null
      msg:  null

    urlRoot: "/notifications/"

  class NotificationsCollection extends Backbone.Collection
    model: NotificationModel
    last: null
    url: "/notifications/"

  @app = window.app ? {}
  
  @app.NotificationModel       = NotificationModel
  @app.NotificationsCollection = NotificationsCollection

