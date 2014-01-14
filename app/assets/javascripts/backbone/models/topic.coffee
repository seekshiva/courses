jQuery ->
  class TopicModel extends Backbone.Model
    paramRoot: 'topic'

    defaults:
      title:        null
      ct_status:    null
      description:  null

    urlRoot: "/topics/"

  class TopicsCollection extends Backbone.Collection
    model: TopicModel
    url: "/topics/"

   
  @app = window.app ? {}
  @app.TopicModel       = TopicModel
  @app.TopicsCollection = TopicsCollection
