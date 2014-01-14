jQuery ->
  class SectionModel extends Backbone.Model
    paramRoot: 'section'

    defaults:
      title:       null
      topics:      null

    urlRoot: "/sections/"

  class SectionsCollection extends Backbone.Collection
    model: SectionModel
    url: "/sections/"

  @app                       = window.app ? {}
  @app.SectionModel          = SectionModel
  @app.SectionsCollection    = SectionsCollection
