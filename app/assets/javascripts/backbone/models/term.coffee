jQuery ->
  class TermModel extends Backbone.Model
    paramRoot: 'term'

    defaults:
      name:        null
      credits:     null
      about:       null
      latest_term: null
      topics:      null

    urlRoot: "/terms/"

  @app = window.app ? {}
  @app.TermModel = TermModel
