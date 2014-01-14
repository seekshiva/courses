jQuery ->
  class TermDocumentModel extends Backbone.Model
    paramRoot: 'term_document'

    defaults:
      id:     null

    urlRoot: "/term_documents/"

  class SectionDocumentModel extends Backbone.Model
    paramRoot: 'section_document'

    defaults:
      id:     null

    urlRoot: "/section_document/"

  class TopicDocumentModel extends Backbone.Model
    paramRoot: 'topic_document'

    defaults:
      id:     null

    urlRoot: "/topic_documents/"

  @app                       = window.app ? {}
  
  @app.TermDocumentModel     = TermDocumentModel
  @app.SectionDocumentModel  = SectionDocumentModel
  @app.TopicDocumentModel    = TopicDocumentModel
