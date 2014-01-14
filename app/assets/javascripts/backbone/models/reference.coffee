jQuery ->
  class ReferenceModel extends Backbone.Model
    paramRoot: "reference"

    defaults:
      term_id:      null
      book_id:      null
      title:        null

    urlRoot: "/references/"

  class TopicReferenceModel extends Backbone.Model
    paramRoot: "topic_reference"

    defaults:
        id:     null

    urlRoot: "/topic_references/"

  class ReferencesCollection extends Backbone.Collection
    model: ReferenceModel
    url: "/references/"


  @app = window.app ? {}
  
  @app.TopicReferenceModel   = TopicReferenceModel
  @app.ReferenceModel        = ReferenceModel
  @app.ReferencesCollection  = ReferencesCollection
  
