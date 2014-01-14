jQuery ->
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

  @app = window.app ? {}
  
  @app.SubscriptionModel       = SubscriptionModel
  @app.SubscriptionsCollection = SubscriptionsCollection
